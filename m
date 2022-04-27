Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D145111CB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358426AbiD0G7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358486AbiD0G6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:58:42 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0465416582
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:55:22 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r83so751385pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/H/dr1bU3IWO2Zz3V0TPFg82hzHtg38B7AemVKe2A0M=;
        b=Swzf4xKjfP1XA2e+DubAp3b10kwTb8AthU76bMCJuIkF5WelHZd8ki7PyrmZBVV73h
         7V0jsT/TNILRELnOmATKXQELGQt181VCk812Hg2n6tfah6g6r7R2L/PSsTy2SWXPPtYc
         VLmH7wlBiSjVx2ZkoP8BNPMn9iXWfbmvOKFZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/H/dr1bU3IWO2Zz3V0TPFg82hzHtg38B7AemVKe2A0M=;
        b=SR6LwFlgxpby03lz1xpNO5IGKEeCB8EQ4/2EG66+EqKGE5HeXSNnXNxOzED/EuxTT4
         lAAZEV5ST//pMZCVQNVuOWflin1Mju3ilE3QozbL3MV8uQvj0kPt3tMrfHtwM7d2M092
         TQQLuqiWMwgaGn/YZaEtSjA+ftYoyg6ND/xAQ/9crU7BUPqYiDYtc1fDV1/LgiWUBWZ5
         QXPHtQ42C5CSAU+HtMZt68mSaZfYwRpzdoRTIO6SumZlhzeRQluL8yjAeHxXnymuiZlh
         +mJLMYN/dj6E91tEgxy/m+qo8FaXCLWsCvOYzZ3BnmYEE++JF21D7cyk7df0zVB80qa1
         MSHw==
X-Gm-Message-State: AOAM533lzUR9tpYxArpDIRkRKNvOcP/9ivkn8Ygbr+CeqFMAYoZLvloE
        IONYmxjZcyHA2iFzQk16+Ch/Aw==
X-Google-Smtp-Source: ABdhPJxAbcUOPHGpu19WyFlEpx1bs/thLds4ctz1Fli9HAULfa6p4OeS6pNFkws8wrL4iVVeIVrnCw==
X-Received: by 2002:a63:df18:0:b0:3ab:938b:e6c5 with SMTP id u24-20020a63df18000000b003ab938be6c5mr5157870pgg.165.1651042522409;
        Tue, 26 Apr 2022 23:55:22 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:8e2d:263:26e7:c039])
        by smtp.gmail.com with ESMTPSA id 7-20020a17090a000700b001da3920d985sm1276416pja.12.2022.04.26.23.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 23:55:21 -0700 (PDT)
Date:   Wed, 27 Apr 2022 15:55:17 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     =?iso-8859-1?Q?P=E9ter?= Ujfalusi 
        <peter.ujfalusi@linux.intel.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaska Uimonen <jaska.uimonen@linux.intel.com>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        sound-open-firmware@alsa-project.org
Subject: Re: out-of-bounds access in sound/soc/sof/topology.c
Message-ID: <Ymjo1aHD4V6bNHz7@google.com>
References: <Ylk5o3EC/hyX5UQ0@google.com>
 <8eeb08ec-4836-cf7d-2285-8ed74ccfc1cb@linux.intel.com>
 <8986a1c6-b546-7a66-a778-048487624c95@linux.intel.com>
 <e31ff7c4-7cdc-fdaf-b12c-fc1e51798a1b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e31ff7c4-7cdc-fdaf-b12c-fc1e51798a1b@linux.intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/04/19 08:07), Pierre-Louis Bossart wrote:
> > Your analyzes are spot on, unfortunately. But...
> > 
> > As of today, the sof_get_control_data() is in the call path of
> > (ipc3-topology.c):
> > 
> > sof_widget_update_ipc_comp_process() -> sof_process_load() ->
> > sof_get_control_data()
> > 
> > sof_widget_update_ipc_comp_process() is the ipc_setup callback for
> > snd_soc_dapm_effect. If I'm not mistaken these only carries bin payload
> > and never MIXER/ENUM/SWITCH/VOLUME.
> > This means that the sof_get_control_data() is only called with
> > SND_SOC_TPLG_TYPE_BYTES and for that the allocated data area is correct.
> > 
> > This can explain why we have not seen any issues so far. This does not
> > renders the code right, as how it is written atm is wrong.
> 
> 
> Sergey's results with KASAN show that there's a real-life problem though. I also don't understand how that might happen.
> 
> Could it be that these results are with a specific topology where our assumptions are incorrect?

Is there anything I can do to help?
