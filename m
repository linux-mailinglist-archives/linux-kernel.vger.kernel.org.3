Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931B54D1F1C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349162AbiCHRaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiCHRaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:30:09 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885C154FA1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:29:12 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a8so40828945ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 09:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version;
        bh=5HWo7Yn4Gz5MyzMbo79AixM1e14Ion9TA4+nwqobfts=;
        b=UAwI49Yij2ze4YdwT6RPfDJ3EUVQfBqZ0e4p/w5tHnnNCbXRZLVm6agSd8QGcJIgvm
         n1t0eUD6HEH5UQmv5aqjTUtnpBEDc6ca9EWQGF5JVgt7GIMzRX9yzrf2kasdfy8RZd41
         E7NNOMgj8A0IF1zOhxmVmNLgmAdj7tVwoeZpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version;
        bh=5HWo7Yn4Gz5MyzMbo79AixM1e14Ion9TA4+nwqobfts=;
        b=VI796c/WLS6NByq+GSNe+93vlxPwr12LTjy+tcsIBWkHgjczl2544icttZsBfDpwTA
         l5xzaTswPHcMd+Na7PoDfmrNueLEJgis9dVvfGcLy8fr04LgSIFeIcYzgWcDfR3E1ENq
         LBMeE8jAlTdtu6pfVtZz8/huXicVHRLLnWD3hzWf/aW1jmUgthpMv1lQR4SJZ8HU+ON9
         aGE/yra+tjAqdjqstoudZwN42GocmSzgpw7BGZP6x22AV5YUZS1Y0j0V5FiKapnEsSX5
         QIdOxyUwmyvtJghMK2tkSf6LNjv8JV1IOWYQ1ts6P7PrkjDrqoEY4kRbwANBSXqoveTs
         fpMg==
X-Gm-Message-State: AOAM532aAroJa+X1UmGZ6dU5Q2D0o4XuODu+ft0cHqQz9fnGT0YcKyTM
        DowVUX5b/hNdtSR9q9nzTRDc6Q==
X-Google-Smtp-Source: ABdhPJyQrpY/JGHHJPPSJCiQDwH2rNmAX+bCSbx3QjYiVYg/4CXFFMiqbSv83KXpXv8mVLuOMmSKhg==
X-Received: by 2002:a17:906:c116:b0:6d6:f8b3:cd47 with SMTP id do22-20020a170906c11600b006d6f8b3cd47mr14753521ejc.501.1646760551007;
        Tue, 08 Mar 2022 09:29:11 -0800 (PST)
Received: from [192.168.178.38] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id k7-20020aa7c047000000b004132d3b60aasm7929467edo.78.2022.03.08.09.29.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Mar 2022 09:29:09 -0800 (PST)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Abel Vesa <abelvesa@linux.com>, Rabin Vincent <rabin@rab.in>,
        Colin Cross <ccross@android.com>
Date:   Tue, 08 Mar 2022 18:29:08 +0100
Message-ID: <17f6a93d6a0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <1dec8992-b924-7ea2-8e45-a6bbc10a6086@nokia.com>
References: <9a86b2c9-1009-1683-442e-61c5a7dc8cf3@broadcom.com>
 <20220307082450.641ed866@gandalf.local.home>
 <62c01368-b67f-66af-2e31-d62f4df75b61@broadcom.com>
 <20220308102007.6c6618e7@gandalf.local.home>
 <1dec8992-b924-7ea2-8e45-a6bbc10a6086@nokia.com>
User-Agent: AquaMail/1.34.0 (build: 103400118)
Subject: Re: ftrace bug
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b0d7b605d9b85100"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b0d7b605d9b85100
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On March 8, 2022 5:03:00 PM Alexander Sverdlin 
<alexander.sverdlin@nokia.com> wrote:

> Hi Arend!
>
> On 08/03/2022 16:20, Steven Rostedt wrote:
>>>> I wanted to use FTRACE on an ARM platform and I hit the following
>>>> warning which results in ftrace bug. This happens upon loading a module.
>>>> Looking up the warning I suspect the branch target is too far off. The
>>>> module is quite large and therefor not loaded in the modules section. Is
>>>> there a way to exclude a module. In ftrace_module_init I see a check for
>>>> !mod->num_ftrace_callsites. Is there a way to avoid creating ftrace
>>>> callsites in a module?
>>> Are you sure it's the size. Just want to make sure that's the reason before
>>> going with different solutions.
>> Interpreting the warning statement in insn.c and given the fact that the
>> module is loaded at 0xe3xxxxxx instead of kernel module space at
>> 0xbfxxxxxx I made this assumption, but ....
>>
>>>> Regards,
>>>> Arend
>>>>
>>>> ------------[ cut here ]------------
>>>>
>>>> WARNING: CPU: 2 PID: 1525 at arch/arm/kernel/insn.c:47
>>>> __arm_gen_branch+0x70/0x78
>>>>
>>>> CPU: 2 PID: 1525 Comm: insmod Tainted: P                  4.19.183 #2
>
> This problem is addressed by:

Cool. Thanks for the info.

> commit 8113e622926ef6590771ede0f7f64821e1751b67
> Author: Alex Sverdlin <alexander.sverdlin@nokia.com>
> Date:   Mon Sep 27 14:02:45 2021 -0700
>
>    ARM: 9079/1: ftrace: Add MODULE_PLTS support
>
>    commit 79f32b221b18c15a98507b101ef4beb52444cc6f upstream
>
>    Teach ftrace_make_call() and ftrace_make_nop() about PLTs.
>    Teach PLT code about FTRACE and all its callbacks.
>    Otherwise the following might happen:
>
>    ------------[ cut here ]------------
>    WARNING: CPU: 14 PID: 2265 at .../arch/arm/kernel/insn.c:14 
>    __arm_gen_branch+0x83/0x8c()
>    ...
>    Hardware name: LSI Axxia AXM55XX
>    [<c0314a49>] (unwind_backtrace) from [<c03115e9>] (show_stack+0x11/0x14)
>    [<c03115e9>] (show_stack) from [<c0519f51>] (dump_stack+0x81/0xa8)
>    [<c0519f51>] (dump_stack) from [<c032185d>] (warn_slowpath_common+0x69/0x90)
>    [<c032185d>] (warn_slowpath_common) from [<c03218f3>] 
>    (warn_slowpath_null+0x17/0x1c)
>    [<c03218f3>] (warn_slowpath_null) from [<c03143cf>] 
>    (__arm_gen_branch+0x83/0x8c)
>    [<c03143cf>] (__arm_gen_branch) from [<c0314337>] (ftrace_make_nop+0xf/0x24)
>    [<c0314337>] (ftrace_make_nop) from [<c038ebcb>] 
>    (ftrace_process_locs+0x27b/0x3e8)
>    [<c038ebcb>] (ftrace_process_locs) from [<c0378d79>] 
>    (load_module+0x11e9/0x1a44)
>    [<c0378d79>] (load_module) from [<c037974d>] (SyS_finit_module+0x59/0x84)
>    [<c037974d>] (SyS_finit_module) from [<c030e981>] (ret_fast_syscall+0x1/0x18)
>    ---[ end trace e1b64ced7a89adcc ]---
>    ------------[ cut here ]------------
>
> And if you wanna stick with 4.19.y, it's included starting from v4.19.209.

Will see if our router kernel team wants to move. At least I can try my own 
experiment with this.

Regards,
Arend




--000000000000b0d7b605d9b85100
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
XSlOP9s1dqWlRRnnNxV7BVC87lkKKy0+1M2DOF6qRYQlnW4EfOyCToYLAG5zeV+AjepMoX6J9bUz
yj4BlDtwH4HFjaRIlPPbdLshUA54/tV84x8woATuLGBq+hTZEpkZAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFKb+3b9pz8zo
0QsCHGb/p0UrBlU+MA0GCSqGSIb3DQEBCwUAA4IBAQCHisuRNqP0NfYfG3U3XF+bocf//aGLOCGj
NvbnSbaUDT/ZkRFb9dQfDRVnZUJ7eDZWHfC+kukEzFwiSK1irDPZQAG9diwy4p9dM0xw5RXSAC1w
FzQ0ClJvhK8PsjXF2yzITFmZsEhYEToTn2owD613HvBNijAnDDLV8D0K5gtDnVqkVB9TUAGjHsmo
aAwIDFKdqL0O19Kui0WI1qNsu1tE2wAZk0XE9FG0OKyY2a2oFwJ85c5IO0q53U7+YePIwv4/J5aP
OGM6lFPJCVnfKc3H76g/FyPyaE4AL/hfdNP8ObvCB6N/BVCccjNdglRsL2ewttAG3GM06LkvrLhv
UCvjMYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMMSnY
h9J/RI6gsHbuMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCT+PcQU4Am3CkzeXKs
eesojmaTNM54jJ02ZsgSKQWXCTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjAzMDgxNzI5MTFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAkh+bwBmT505bZY8qBOYNX8ovYfWz+aOvJCX9
DsGP/o2pyM5eDw00GGdzrEtgvOEbVIWQbmGxroMGEwcq4q6sP2c878+SYajXPmGazGV+PhXTOpW0
Gu0y9nAelEBky2IdueE7r24y5TRe5nDGAe6tU4hpdJKijcoUBPTgWoX6JEWiuHkOT/ilUrC39jx+
jIIUCLmfTZXHx0K2JYzbBnqcjYeHj61Ql1Pj9XzKOO8+sYDBgWSLn1+N8wg4egwXbAyaVncT7zDW
UWSjBA/0YWLZ1AccYh1nt3hmS8qozqHmygfEG09iM/8UGlX2wZKim36+ynyX91lmywjfvbE6+pg1
1w==
--000000000000b0d7b605d9b85100--
