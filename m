Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AC04BD095
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 19:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243487AbiBTSEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 13:04:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbiBTSEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 13:04:00 -0500
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EAC41635
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 10:03:38 -0800 (PST)
Received: from [192.168.8.33] (unknown [90.19.9.37])
        (Authenticated sender: eric.valette@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 7A5715FF33;
        Sun, 20 Feb 2022 19:03:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1645380216;
        bh=IukDJ5h4L2PHp9stLtKdlNNaLlvJkJUdojizUPTPeKM=;
        h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rhWZ1j23EvxNsTknNLs/om+90oVmS28biKPyhdT0QbJKoeCDCPP/IkJNUAT/7Iiws
         nwFNm3+uHfm6F5dEPB+CiraRY8nhNVeGMhiNc1H4WmVJXdtxvKd11zFwtqbQYhrjB+
         tP8jetzDa2dp08glWC1IjM63nqUJ7yWbxHXMCNkjt0C2NA8aMAIHMZx2zjTU6gE+D4
         iRs3ese+SaeryZ7VV0NPAMLHjFcKoFVb/AtQybhKlngF7GnyrRPoQrIrQPIbJT7c3Q
         9Pq4H0XINOZM9iesgyddmAcGAzy155Jrx9IYRprJG212qCesOH0Se9anppF4NwLiU0
         44zHDMMtzfZwQ==
Message-ID: <c62d4ba9-2214-ca7d-ee78-ee19a9bf51e6@free.fr>
Date:   Sun, 20 Feb 2022 19:03:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: eric.valette@free.fr
Subject: Re: Regression from 3c196f056666 ("drm/amdgpu: always reset the asic
 in suspend (v2)") on suspend?
Content-Language: en-US
To:     dod@debian.org, Salvatore Bonaccorso <carnil@debian.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, 1005005@bugs.debian.org,
        Luben Tuikov <luben.tuikov@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <Ygf7KuWyc0d4HIFu@eldamar.lan>
 <CADnq5_MfR99OhjumQESCO7Oq+JVOHOVgyVQHX4FpGFDnPu6CyQ@mail.gmail.com>
 <5164225.DI6hChFYCN@ylum>
From:   Eric Valette <eric.valette@free.fr>
Organization: HOME
In-Reply-To: <5164225.DI6hChFYCN@ylum>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2022 16:48, Dominique Dumont wrote:
> On Monday, 14 February 2022 22:52:27 CET Alex Deucher wrote:
>> Does the system actually suspend?
> 
> Not really. The screens looks like it's going to suspend, but it does come
> back after 10s or so. The light mounted in the middle of the power button does
> not switch off.


As I have a very similar problem and also commented on the original 
debian bug report 
(https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1005005), I will add 
some information here on another amd only laptop (renoir AMD Ryzen 7 
4800H with Radeon Graphics + Radeon RX 5500/5500M / Pro 5500M).

For me the suspend works once, but after the first resume (I do know 
know if it is in the suspend path or the resume path I see a RIP in the 
dmesg (see aditional info in debian bug))  and later suspend do not 
work: It only go to the kde login screen.

I was unable due to network connectivity to do a full bisect but tested 
with the patch I had on my laptop:

5.10.101 works, 5.10 from debian works
5.11 works
5.12 works
5.13 suspend works but when resuming the PC is dead I have to reboot
5.14 seems to work but looking at dmesg it is full of RIP messages at 
various places.
5.15.24 is a described 5.15 from debian is behaving identically
5.16 from debian is behaving identically.

>> Is this system S0i3 or regular S3?

For me it is real S3.

The proposed patch is intended for INTEl + intel gpu + amdgpu but I have 
dual amd GPU.

--eric


