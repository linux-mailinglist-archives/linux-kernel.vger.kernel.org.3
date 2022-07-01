Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E17563730
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiGAPsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiGAPsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:48:23 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE23C2BE4;
        Fri,  1 Jul 2022 08:48:22 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d17so2800907pfq.9;
        Fri, 01 Jul 2022 08:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uDarOweoEFTnSdrDvDJllZpMrSn4p19JOAzdu5dS6Q8=;
        b=bRO4mWU70FDfLNjJsSu+cVGSWroljHlQf21xyBvmpZpeik91heVqs0IY7cEDK7l4mx
         3g9CTuSDehyr1Epvl/PVWCIOTvCIKaaSkQqhH/3F3PQ4KnsBxejzF8XigGQpDPWkVoh1
         Q9+vJMW3d6mMxG7wNtkYkBn7X8gT5D/3WZlQj7KSLfA//vMn91A26MuvxKSXf6OaK12L
         NSyqHS4NUo1ibsrm1gNp8jAO0g7bAPH/VX5JRykRCSs7Y3XtBf+WsVEnfuf/OccvI4sI
         GKzzLXjzVJRe5fzJJsBKpSU00UCMIe2DF0/JW7cPl3KvItSaM8EwNF3UmhZBfG5hY8Ym
         gddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uDarOweoEFTnSdrDvDJllZpMrSn4p19JOAzdu5dS6Q8=;
        b=CcOC22nLd9GFi0WYCkmxxiq6dEUKGo6+N5xq4OMianmL9oFf8bDbx+Isb2YTconxKV
         3w6qSLCmpKnihFMXkCpjDppMdELrGFPPQvBPVFmnfl739Givbet8s6Lminb9MUAEjvy1
         wosC8nPNeLq0fGdnWDOBuY39bpfUP6pp/sDsYg2mgxWOqLSW+tZDvhjh1NV3oiaEtzak
         tr62xdTbwEBaotCIIrZbSf5gXdPfYBJU5u2N21NSHIO9W8YXw3zRn/CZ7YUtAj1It4kf
         /vnEQfWw0bC+IoYkBIyvS5fPbBuU5TIOrsxsEtd9sf65V4LTiotDQuiC0qFKhOqnwNSn
         LaMQ==
X-Gm-Message-State: AJIora9ZyLwPd03tWC/ZA1hES12KlKbRC3BvFjH5vnM720SvgMbrTVs2
        6BfMSPegFmY1AqOqWPgEcGY=
X-Google-Smtp-Source: AGRyM1vfLcBhdXKZWt1lvdyF/YoLNAqePnjUFcOc+RzzizmYni7T7Qzzp4B5x7Vu/sCebE85txfhuQ==
X-Received: by 2002:a63:8142:0:b0:40d:314c:57bd with SMTP id t63-20020a638142000000b0040d314c57bdmr12487367pgd.427.1656690502215;
        Fri, 01 Jul 2022 08:48:22 -0700 (PDT)
Received: from [192.168.31.116] (dhcp-v209-042.vp.reshsg.uci.edu. [169.234.209.42])
        by smtp.gmail.com with ESMTPSA id s42-20020a056a0017aa00b0052553215444sm16075338pfg.101.2022.07.01.08.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 08:48:21 -0700 (PDT)
Message-ID: <cfc06d1d-4019-b358-fd81-10d55e1868e5@gmail.com>
Date:   Fri, 1 Jul 2022 08:48:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/2] ACPI: CPPC: Only probe for _CPC if CPPC v2 is
 acked
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Huang Rui <ray.huang@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        perry.yuan@amd.com, maxim.novozhilov@gmail.com,
        lethe.tree@protonmail.com, garystephenwright@gmail.com,
        galaxyking0419@gmail.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220701022529.2134-1-mario.limonciello@amd.com>
From:   CUI Hao <cuihao.leo@gmail.com>
In-Reply-To: <20220701022529.2134-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 09:25:27PM -0500, Mario Limonciello wrote:
> Previously the kernel used to ignore whether the firmware masked CPPC
> or CPPCv2 and would just pretend that it worked.
> 
> When support for the USB4 bit in _OSC was introduced from commit
> 9e1f561afb ("ACPI: Execute platform _OSC also with query bit clear")
> the kernel began to look at the return when the query bit was clear.
> 
> This caused regressions that were misdiagnosed and attempted to be solved
> as part of commit 2ca8e6285250 ("Revert "ACPI: Pass the same capabilities
> to the _OSC regardless of the query flag""). This caused a different
> regression where non-Intel systems weren't able to negotiate _OSC
> properly.
> 
> This was reverted in commit 2ca8e6285250 ("Revert "ACPI: Pass the same
> capabilities to the _OSC regardless of the query flag"") and attempted to
> be fixed by commit c42fa24b4475 ("ACPI: bus: Avoid using CPPC if not
> supported by firmware") but the regression still returned.
> 
> These systems with the regression only load support for CPPC from an SSDT
> dynamically when _OSC reports CPPC v2.  Avoid the problem by not letting
> CPPC satisfy the requirement in `acpi_cppc_processor_probe`.
> 
> Reported-by: CUI Hao <cuihao.leo@gmail.com>
> Reported-by: maxim.novozhilov@gmail.com
> Reported-by: lethe.tree@protonmail.com
> Reported-by: garystephenwright@gmail.com
> Reported-by: galaxyking0419@gmail.com
> Fixes: c42fa24b4475 ("ACPI: bus: Avoid using CPPC if not supported by firmware")
> Fixes: 2ca8e6285250 ("Revert "ACPI Pass the same capabilities to the _OSC regardless of the query flag"")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=213023
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2075387
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I tested the patch on 5.19-rc4 kernel, and confirm that it fixes the ACPI errors:
ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PR00._CPC] on my ASRock B460M-ITX/ac + i7-10700K machine. New to kernel lists. If my Thunderbird doesn't mangle the text, feel free to add:

Tested-by: CUI Hao <cuihao.leo@gmail.com>

