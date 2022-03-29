Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EBF4EAE76
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbiC2N3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbiC2N3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:29:31 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF851FAA02;
        Tue, 29 Mar 2022 06:27:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r64so10307023wmr.4;
        Tue, 29 Mar 2022 06:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G7wKFxgcRTyIz5IG5tUGfB7pPXreJmvY/K1sYJIVl3I=;
        b=I00DfUbeycyG0Dw8STKxnaghIk9ou0vzsESvQVIMlrT8eVhJ76sub43aulNKFPwOcL
         UxrZOHCljyEJ/HaDNgCUIWBpBVJkWgK72ksZvBA9QY9H26c0L2pomM05DJyeVdODJT1L
         ZDfmiULPqoY2YzMsRX9s3BZ6fZr0wWScSEvGAiN9EQhsRv4ZtMXuYOhzvXy24lUBQ6bK
         U212hp2O1hlrhP4Lp/BXhgcuubNm0q3C4fqZCCg6NFMcEZcjVMCujqezRMtTGXjKH7oa
         0ZByXf7N6pXKbL6bthUbJE+CpVy+hujtl+uEEi1+0UgZK+4eW7VFAsNQ9iZNA1q+EUqB
         EltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G7wKFxgcRTyIz5IG5tUGfB7pPXreJmvY/K1sYJIVl3I=;
        b=ci3zHiAebBy1wPfbrr/kpTqx3K2h0o8aQB0VVGYl15zWUPsUOZLpMXJwBAS40cU+um
         MnEPd77zbNFQlbgxrPdKJ36Am8YKVEIKGi/1PZEc7ZR24JexuFmhs7I8b7AA2D8vO1NC
         +41GeEv5rd85at3Tyr0IKVYmUoM0PdLK3bPv7GkP2csJpKQTHF5iU4I0zP4Fwvec9BLr
         RmSh0lJenvjjzSPIr5iI420FqhqZAQ+R8GDLjq+0Vvbq5mh9Qwn4ZjAScIFjv8EGcpYK
         p/mfFXlMvUu1lfaQH9iGtY4KBejrfWW+LUEQGsu7nE2mAhxVoAJHLfJNmucFA5QU+vUM
         Uvcg==
X-Gm-Message-State: AOAM5301UfoDLv+TbhW6fQMYLZPfJq+5PeLCtuUBFwRuDp6u8EKjOSyJ
        ZEcefdOOc0wWo1i68YDuLOA=
X-Google-Smtp-Source: ABdhPJxIZSXxt+SSJ4Wc109LDmTnDkbhvm93ISr03t8O0S/WPjtqWVCeq9qxFzIweZuojWFD/xazLQ==
X-Received: by 2002:a05:600c:4f82:b0:38c:9185:1ecd with SMTP id n2-20020a05600c4f8200b0038c91851ecdmr6880980wmq.130.1648560465761;
        Tue, 29 Mar 2022 06:27:45 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-66-93.ip85.fastwebnet.it. [93.42.66.93])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm2193197wmv.31.2022.03.29.06.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 06:27:44 -0700 (PDT)
Date:   Tue, 29 Mar 2022 06:56:02 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org,
        linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
Message-ID: <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 03:20:18PM +0200, Krzysztof Kozlowski wrote:
> On 28/03/2022 02:09, Ansuel Smith wrote:
> > Hi,
> > as the title say, the intention of this ""series"" is to finally categorize
> > the ARM dts directory in subdirectory for each oem.
> > 
> > The main reason for this is that it became unpractical to handle 2600
> > dts files and try to even understand/edit/check the situation for a
> > specific target.
> > 
> > In arm64 we already have this kind of separation and I honestly think
> > that this was never proposed for ARM due to the fact that there are
> > 2600+ files to sort and the fact that it will be a mess to merge this
> > entirely but IMHO with a little bit of effort we can finally solve this
> > problem and have a well organized directory just like arm64.
> > 
> > Some prerequisite on how this work was done:
> > - This comes entirely from a python script created by me for the task.
> >   linked here [1]
> > - I had to manually categorize all the different arch in the makefile
> >   based on the oem. I searched every arch on the internet trying to
> >   understand the correct oem. I hope they are correct but I would love
> >   some comments about them.
> > - This current ""series"" is all squashed in one big commit to better
> >   receive comments for this. The final version ideally would have all
> >   changes in separate commits. The script can already do this, it's just
> >   commented.
> > 
> > Here is a list of some discoveries while doing all the sorting.
> > These are totally additional reason why we need this.
> > 
> > While creating the script I discovered some funny things:
> > - We have orphan dts! There are dts that are never compiled and are
> >   there just for reference. We would never have noticed this without this
> >   change and probably nobody noticed it. They are currently all listed
> >   in the python script.
> > - We have dtsi shared across different oem. My current solution for them
> >   is: NOT SORT THEM and leave them in the generic directory and create a
> >   link in each oem dts that points to these dtsi. This is to try in
> >   every way possible to skip any additional changes to the dts.
> >   Current dtsi that suffers from this are only 3. (listed in the script)
> > - arm64 dts and dtsi reference ARM dts. Obviously this change would cause
> >   broken include for these special dtsi. The script creates a dependency
> >   table of the entire arm64 directory and fix every broken dependency
> >   (hoping they all use a sane include logic... regex is used to parse
> >   all the different dependency)
> > 
> > So in short the script does the following steps:
> > 1. Enumerate all the action to do... (dts to move, scan dependency for
> >    the dts...)
> > 2. Generate the arm64 dependency
> > 3. Creates the Makefile
> > 4. Generate the Makefiles for the current oem
> > 5. Move all the related dts and dtsi for the current oem
> > 6. Check broken dependency and fix them by editing the dts and writing
> >    the correct include (or fix any symbolic link)
> > 
> > This is an output that describes all the things done by the script [2]
> > 
> > I really hope I didn't commit any logic mistake in the script but most
> > of the work should be done.
> > 
> 
> +Cc Arnd and Olof,
> 
> Ansuel,
> Thanks for you patch. Please cc the SoC maintainers in such submissions.
> It seems that you got some quite nice discussion, but still the core
> folks are not Cced, so no one would be able to take your patch...
>

I had some problem with gmail and sending mail too much users. I put Rob
and You and all the various list to try to workaround the "gmail spam
protection"

> I am pretty sure we were discussing such split idea in the past and it
> did not get traction, but I cannot recall the exact discussion.
> 

I think the main issue here is how to handle bot and how problematic is
to merge this. As written in the cover letter the final version of this
should be a big series of 50+ patch with every commit specific to each
oem. In theory we should be able to merge the different oem separately
and try to at least start the categorization. 
Another idea I got to at least have a "migration path" is to convert
every dts in the dts/ directory to a symbolic link that target the dts
in the correct oem. But I assume that would fix only part of the problem
and git am will still be problematic.

> To me the idea is good but will cause huge `git am` conflicts.
> Cherry-picks, backports and merges should nicely detect path renames,
> but git am (and b4 am) I think cannot.
> 

I know but we should really consider this kind of change. The current
state of the dts/ directory is embarassing and keeping it that way cause
only more problems and makes this even more difficult.
Hope we find a solution and fix this for good!

> Best regards,
> Krzysztof

-- 
	Ansuel
