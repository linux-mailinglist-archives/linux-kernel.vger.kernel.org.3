Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EFC4E4665
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 20:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiCVTBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 15:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiCVTBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 15:01:04 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792668E18C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:59:35 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 2628C3F838;
        Tue, 22 Mar 2022 19:59:33 +0100 (CET)
Date:   Tue, 22 Mar 2022 19:59:25 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Jonathan Marek <jonathan@marek.ca>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [Freedreno] [PATCH v3 12/13] drm/msm/dsi: Add support for DSC
 configuration
Message-ID: <20220322185925.nszstmi5silgefd5@SoMainline.org>
References: <20211116062256.2417186-1-vkoul@kernel.org>
 <20211116062256.2417186-13-vkoul@kernel.org>
 <20211211000315.pavmcc7cc73ilb6l@SoMainline.org>
 <Yg4t/G3tgcmkswHg@matsya>
 <20220217151142.sbp6wslxbxeohsgf@SoMainline.org>
 <YjoEgpAZAwM8hWEa@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjoEgpAZAwM8hWEa@matsya>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-22 22:46:50, Vinod Koul wrote:
> On 17-02-22, 16:11, Marijn Suijten wrote:
> > Hi Vinod,
> > 
> > Thanks for taking time to go through this review, please find some
> > clarifications below.
> > 
> > On 2022-02-17 16:44:04, Vinod Koul wrote:
> > > Hi Marijn,
> > > 
> > > On 11-12-21, 01:03, Marijn Suijten wrote:
> > > 
> > > > > +static int dsi_dsc_update_pic_dim(struct msm_display_dsc_config *dsc,
> > > > > +				  int pic_width, int pic_height)
> > > > 
> > > > This function - adopted from downstream - does not seem to perform a
> > > > whole lot, especially without the modulo checks against the slice size.
> > > > Perhaps it can be inlined?
> > > 
> > > Most of the code here is :)
> > > 
> > > This was split from downstream code to check and update dimension. We
> > > can inline this, or should we leave that to compiler. I am not a very
> > > big fan of inlining...
> > 
> > It doesn't seem beneficial to code readability to have this function,
> > which is only called just once and also has the same struct members read
> > in a `DBG()` directly, abstracted away to a function.  Not really
> > concerned about generated code/performance FWIW.
> > 
> > Also note that the caller isn't checking the `-EINVAL` result...
> 
> I have made this void inline.

Perhaps there is a misunderstanding here: with inlining I am referring
to the process of transplanting the _function body_ to the only
call-site, not adding the `inline` keyword nor changing this to `void`.

The checks that make this function return `-EINVAL` seem valid, so the
caller should check it instead of removing the return?

> > > > 
> > > > > +{
> > > > > +	if (!dsc || !pic_width || !pic_height) {
> > > > > +		pr_err("DSI: invalid input: pic_width: %d pic_height: %d\n", pic_width, pic_height);
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > > +	dsc->drm->pic_width = pic_width;
> > > > > +	dsc->drm->pic_height = pic_height;
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > >  static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
> > > > >  {
> > > > >  	struct drm_display_mode *mode = msm_host->mode;
> > > > > @@ -940,7 +954,68 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
> > > > >  		hdisplay /= 2;
> > > > >  	}
> > > > >  
> > > > > +	if (msm_host->dsc) {
> > > > > +		struct msm_display_dsc_config *dsc = msm_host->dsc;
> > > > > +
> > > > > +		/* update dsc params with timing params */
> > > > > +		dsi_dsc_update_pic_dim(dsc, mode->hdisplay, mode->vdisplay);
> > 
> > That is, the result code here should be checked (or function inlined).
> 
> This function return void, so no point in checking

It isn't returning `void` in the current patch series that my email is
reviewing, hence explicitly mentioning here that it may have been
overlooked.

Please only convert this to `void` if you are sure that the clause that
originally made `dsi_dsc_update_pic_dim()` return `-EINVAL` on invalid
input is unreachable (if, for example, you moved this check to another
location, say here in `dsi_timing_setup`).

Alas, it's pretty tricky to reason and pose assumptions about code that
I cannot see; we should probably continue this discussion in the next
patch revision depending on how it looks :)

> > [..]
> > Thanks.  I forgot to mention: there seem to be a lot of similarities
> > between the video and commandmode computations, can those possibly be
> > factored out of the if-else to save on duplication and accidental
> > mismatches like these?
> 
> Thanks, this was a good suggestion and am happy to report that I have
> incorporated this and indeed code looks better

Thank you for applying this and the other comments, glad to hear the
code is shaping up and looking forward to the next revision!

- Marijn
