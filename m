Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595FA4F65AB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbiDFQfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbiDFQez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:34:55 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0D741C17F;
        Tue,  5 Apr 2022 18:46:00 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5E0FD839BA;
        Wed,  6 Apr 2022 03:45:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1649209555;
        bh=v3oFc7B9bk2XqycnFoV04ixZ2YcCpeqjwMggrSrn75U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=o4J3v1s3ENNJEYYwqYgvj1wHS6f9tcldZPd7pkPdyzU6mW3Rol9t91MY41+ydOFqP
         0+mAXb9BdNRZ2rgPZJELmfBa6E4gzP2kSyYospn3W4EdT82ZcOnH7cB2Z65VruxKdR
         mOqgA4gc3aKwE8vKKIvh6unJbnqA7H0GJOPFkoyUuK1PErGEavYAv622jrZA8FJHTe
         AFRZP+T+p11ZJOuJOaODsOnGV3lBVABwYHlSCsCZGYEhQJh1PEp+WXBohaylgwS4kZ
         35eOXXxc7NIJJJznSlFPJRyzhqXWcV9M+Mg0oblqaqIj+YdwmsVHAJ3ajIvwgY1t0h
         fcGjS6QUK0LAw==
Message-ID: <481e40a3-bf84-1b04-b6e6-2a74a0b4b6fe@denx.de>
Date:   Wed, 6 Apr 2022 03:45:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: linux-next: build warning after merge of the drm-misc tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220406105828.6d238651@canb.auug.org.au>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20220406105828.6d238651@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 02:58, Stephen Rothwell wrote:
> Hi all,

Hi,

> After merging the drm-misc tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> WARNING: modpost: drivers/gpu/drm/bridge/chipone-icn6211.prelink.o(.exit.data+0x0): Section mismatch in reference from the variable __cfi_jt_cleanup_module to the function .init.text:cleanup_module()
> The variable __exitdata __cfi_jt_cleanup_module references
> a function __init cleanup_module().
> This is often seen when error handling in the exit function
> uses functionality in the init path.
> The fix is often to remove the __init annotation of
> cleanup_module() so it may be used outside an init section.
> 
> Introduced by commit
> 
>    8dde6f7452a1 ("drm: bridge: icn6211: Add I2C configuration support")
> 
> The chipone_exit function should not be marked __init.

Thanks, fix is submitted.

Sigh.
