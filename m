Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0164BE291
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355422AbiBULNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:13:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355457AbiBULMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:12:30 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB6E1098
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:46:37 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aebce.dynamic.kabel-deutschland.de [95.90.235.206])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id E3ECD61E64846;
        Mon, 21 Feb 2022 11:46:34 +0100 (CET)
Message-ID: <c3ac5d95-218f-4f36-fbec-0172af69d5a0@molgen.mpg.de>
Date:   Mon, 21 Feb 2022 11:46:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] drm/amdgpu: check vm ready by evicting
Content-Language: en-US
To:     Qiang Yu <qiang.yu@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220221101239.2863-1-qiang.yu@amd.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220221101239.2863-1-qiang.yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Qiang Yu,


Am 21.02.22 um 11:12 schrieb Qiang Yu:


Thank you for your patch. Reading the commit message summary, I have no 
idea what “check vm ready by evicting” means. Can you please rephrase it?

> Workstation application ANSA/META get this error dmesg:

What version, and how can this be reproduced exactly? Just by starting 
the application?

> [drm:amdgpu_gem_va_ioctl [amdgpu]] *ERROR* Couldn't update BO_VA (-16)
> 
> This is caused by:
> 1. create a 256MB buffer in invisible VRAM
> 2. CPU map the buffer and access it causes vm_fault and try to move
>     it to visible VRAM
> 3. force visible VRAM space and traverse all VRAM bos to check if
>     evicting this bo is valuable
> 4. when checking a VM bo (in invisible VRAM), amdgpu_vm_evictable()
>     will set amdgpu_vm->evicting, but latter due to not in visible
>     VRAM, won't really evict it so not add it to amdgpu_vm->evicted
> 5. before next CS to clear the amdgpu_vm->evicting, user VM ops
>     ioctl will pass amdgpu_vm_ready() (check amdgpu_vm->evicted)
>     but fail in amdgpu_vm_bo_update_mapping() (check
>     amdgpu_vm->evicting) and get this error log
> 
> This error won't affect functionality as next CS will finish the
> waiting VM ops. But we'd better clear the error log by check the

s/check/checking/

> evicting flag which really stop VM ops latter.

stop*s*?

Can you please elaborate. Christian’s and your discussions was quite 
long, so adding a summary, why this approach works and what possible 
regressions there are going to be might be warranted.


Kind regards,

Paul


> Signed-off-by: Qiang Yu <qiang.yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 37acd8911168..2cd9f1a2e5fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -770,11 +770,16 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>    * Check if all VM PDs/PTs are ready for updates
>    *
>    * Returns:
> - * True if eviction list is empty.
> + * True if VM is not evicting.
>    */
>   bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>   {
> -	return list_empty(&vm->evicted);
> +	bool ret;
> +
> +	amdgpu_vm_eviction_lock(vm);
> +	ret = !vm->evicting;
> +	amdgpu_vm_eviction_unlock(vm);
> +	return ret;
>   }
>   
>   /**
