Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB00510AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355271AbiDZVLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243506AbiDZVLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:11:22 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719306D4D9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:08:13 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso13919918otj.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oOiTDP3iRudLqeNHeG0SSRW6WmEyHCfQv2s8km2VlTE=;
        b=WDTZ94gF93fjDziFhbGcTO4t4Fb/nL5VtVyHG6Ts5gCsTQhihFrg7+V1o9Sd/Jb6uj
         0K926cPr51FkS2ZmVZI7JldZ7tV7kZleje8iOFZXRVrZ5zDen7sPH25Y+LMpVj938v7k
         LXWv3boI1jWsY3svbz09SJIiMfLXj1P/AYtuY+xeklmkK3LNKsO3ipZqISKdJ9fyqa79
         2jIkctsiXnV2lnRwAP70rBzUqJFmQIqodJIW8E5iHPaHuVGy0yUnv83pAsawmbDM421r
         oHgVUK+7PsbamxlEVxbKVnCIjw0toSxdoxU/M4EjaiQzsba73CcdDD1vak0O1JTzCfHL
         Jdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oOiTDP3iRudLqeNHeG0SSRW6WmEyHCfQv2s8km2VlTE=;
        b=ERYigmHlbx9rZsucKfgpVQxc4g1QkNtx2Q6nm0Wv8AIQn9wHBGJQMgglMQHHJSwkBB
         YbgifIRXCSO3dFrk5iiJ3PswAyj74HKCnYywp2zBZQPpoZ/36g3uMBBempcAabY3pVaC
         8DLYoIE+0t0/NIRgH9OOo2c4NkYVe1rvMl4NVCAXTbjmLR8JC3foJA8lTHjPZyylteeF
         LRtY3+aUBmyFcXMrAUoWj13L3RIt+XON0Iwc5Hnt8TwDa05d4JwX0BC2y3v3aofq9umS
         H2m9W5iuYLJOxHaTSIND+6qpnmawPKpKXAp7j+92SbHeF17PqKHaWBbYlchxcsSZxNcp
         1nUQ==
X-Gm-Message-State: AOAM532vaEgrXmF2p17tGtYArXObeCfWUgdl1q+HHiBrBF494rqpSlOt
        bzg/rvlpy0RYnKZIyqQU2JI5Zg==
X-Google-Smtp-Source: ABdhPJxuUikNONG8mH33MVObRzni7bUGk5YoSD2Bver9T2lndjY1DS4aTsdLXeTx1lspBkANXd5yRw==
X-Received: by 2002:a9d:6e83:0:b0:605:4a01:1d8c with SMTP id a3-20020a9d6e83000000b006054a011d8cmr8928613otr.174.1651007292783;
        Tue, 26 Apr 2022 14:08:12 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id t28-20020a056808159c00b00325361c4fbesm2553898oiw.5.2022.04.26.14.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 14:08:11 -0700 (PDT)
Date:   Tue, 26 Apr 2022 14:10:08 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Clark <robdclark@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robert Foss <robert.foss@linaro.org>
Subject: Re: [PATCH 2/2] Revert "drm: of: Lookup if child node has panel or
 bridge"
Message-ID: <YmhfsGAJjSmSPs/l@ripper>
References: <20220421082358.ivpmtak3ednvddrc@houat>
 <YmEdAVwZuA7Wo1Ch@aptenodytes>
 <YmelPCcWCCjALtRU@aptenodytes>
 <YmfYi5G7hMKLAH3T@pendragon.ideasonboard.com>
 <YmfoiD0r8MD/kr1N@aptenodytes>
 <20220426125401.yyrhg6aeafdjw4ad@houat>
 <20220426125544.mroteu3hvyvlyb6g@houat>
 <Ymft0SM5GNHXjkVb@aptenodytes>
 <20220426131944.b26rqqmk7gpcplbg@houat>
 <Ymf4nmQAkEciwyt/@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymf4nmQAkEciwyt/@aptenodytes>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26 Apr 06:50 PDT 2022, Paul Kocialkowski wrote:

> On Tue 26 Apr 22, 15:19, Maxime Ripard wrote:
> > On Tue, Apr 26, 2022 at 03:04:17PM +0200, Paul Kocialkowski wrote:
> > > On Tue 26 Apr 22, 14:55, Maxime Ripard wrote:
> > > > On Tue, Apr 26, 2022 at 02:54:01PM +0200, Maxime Ripard wrote:
> > > > > On Tue, Apr 26, 2022 at 02:41:44PM +0200, Paul Kocialkowski wrote:
> > > > > > On Tue 26 Apr 22, 14:33, Laurent Pinchart wrote:
> > > > > > > On Tue, Apr 26, 2022 at 09:54:36AM +0200, Paul Kocialkowski wrote:
> > > > > > > > On Thu 21 Apr 22, 10:59, Paul Kocialkowski wrote:
> > > > > > > > > On Thu 21 Apr 22, 10:23, Maxime Ripard wrote:
> > > > > > > > > > On Thu, Apr 21, 2022 at 01:15:54PM +0530, Jagan Teki wrote:
> > > > > > > > > > > + Linus
> > > > > > > > > > > + Marek
> > > > > > > > > > > + Laurent
> > > > > > > > > > > + Robert
> > > > > > > > > > > 
> > > > > > > > > > > On Thu, Apr 21, 2022 at 4:40 AM Bjorn Andersson wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Commit '80253168dbfd ("drm: of: Lookup if child node has panel or
> > > > > > > > > > > > bridge")' attempted to simplify the case of expressing a simple panel
> > > > > > > > > > > > under a DSI controller, by assuming that the first non-graph child node
> > > > > > > > > > > > was a panel or bridge.
> > > > > > > > > > > >
> > > > > > > > > > > > Unfortunately for non-trivial cases the first child node might not be a
> > > > > > > > > > > > panel or bridge.  Examples of this can be a aux-bus in the case of
> > > > > > > > > > > > DisplayPort, or an opp-table represented before the panel node.
> > > > > > > > > > > >
> > > > > > > > > > > > In these cases the reverted commit prevents the caller from ever finding
> > > > > > > > > > > > a reference to the panel.
> > > > > > > > > > > >
> > > > > > > > > > > > This reverts commit '80253168dbfd ("drm: of: Lookup if child node has
> > > > > > > > > > > > panel or bridge")', in favor of using an explicit graph reference to the
> > > > > > > > > > > > panel in the trivial case as well.
> > > > > > > > > > > 
> > > > > > > > > > > This eventually breaks many child-based devm_drm_of_get_bridge
> > > > > > > > > > > switched drivers.  Do you have any suggestions on how to proceed to
> > > > > > > > > > > succeed in those use cases as well?
> > > > > > > > > > 
> > > > > > > > > > I guess we could create a new helper for those, like
> > > > > > > > > > devm_drm_of_get_bridge_with_panel, or something.
> > > > > > > > > 
> > > > > > > > > Oh wow I feel stupid for not thinking about that.
> > > > > > > > > 
> > > > > > > > > Yeah I agree that it seems like the best option.
> > > > > > > > 
> > > > > > > > Should I prepare a patch with such a new helper?
> > > > > > > > 
> > > > > > > > The idea would be to keep drm_of_find_panel_or_bridge only for the of graph
> > > > > > > > case and add one for the child node case, maybe:
> > > > > > > > drm_of_find_child_panel_or_bridge.
> > > > > > > > 
> > > > > > > > I really don't have a clear idea of which driver would need to be switched
> > > > > > > > over though. Could someone (Jagan?) let me know where it would be needed?
> > > > > > > > 
> > > > > > > > Are there cases where we could both expect of graph and child node?
> > > > > > > > (i.e. does the new helper also need to try via of graph?)
> > > > > > > 
> > > > > > > I still think we should use OF graph uncondtionally, even in the DSI
> > > > > > > case. We need to ensure backward-compatibility, but I'd like new
> > > > > > > bindings (and thus new drivers) to always use OF graph.
> > > > > > 
> > > > > > I just went over the thread on "drm: of: Improve error handling in bridge/panel
> > > > > > detection" again and I'm no longer sure there's actually still an issue that
> > > > > > stands, with the fix that allows returning -ENODEV when possible.
> > > > > > 
> > > > > > The remaining issue that was brought up was with a connector node, but it should
> > > > > > be up to the driver to detect that and avoid calling drm_of_find_panel_or_bridge
> > > > > > in such situations.
> > > > > > 
> > > > > > So with that in mind it feels like the child node approach can be viable
> > > > > > (and integrated in the same helper).
> > > > > > 
> > > > > > We might still want to favor an explicit OF graph approach, but note that
> > > > > > dsi-controller.yaml also specifies extra properties that are specific to
> > > > > > MIPI DSI and I'm not sure there are equivalent definitions for the OF graph
> > > > > > approach.
> > > > > > 
> > > > > > What do you think?
> > > > > 
> > > > > I don't think Laurent's point was to move the child node away from its
> > > > > DSI controller, that part doesn't make much sense. The panel or bridge
> > > > > is still accessed through the DSI bus, so it very much belongs there.
> > > > > 
> > > > > What he meant I think was that we mandate the OF graph for all panels,
> > > > > so for panels/bridges controlled through DCS, you would still list the
> > > > > output through the graph.
> > > > 
> > > > Also, we're already in a bit of a mess right now. I don't think rushing
> > > > that kind of patches in a (late) rc is making much sense, but as I said,
> > > > if you want to start working on this, then I'll take a revert for the
> > > > next rc, and then we can work calmly on this.
> > > 
> > > As I understand it we either have some broken stuff because of the revert of:
> > > - drm: of: Lookup if child node has panel or bridge
> > > - drm: of: Properly try all possible cases for bridge/panel detection
> > > 
> > > because the child node is already used in places, or we can have broken stuff
> > > because with the patches because with these two patches -ENODEV is no longer
> > > returned.
> > > 
> > > Now with the extra patch that I sent:
> > > - drm: of: Improve error handling in bridge/panel detection
> > > 
> > > we get -ENODEV back, except for the connector case but this one should be
> > > handled in drivers directly and drm_of_find_panel_or_bridge should not be
> > > called in that situation.
> > > 
> > > So all in all it seems that all the pieces are there, unless I'm missing
> > > something.
> > > 
> > > What do you think?
> > 
> > If Bjorn and Thierry can confirm that it indeeds work in their case,
> > I'll be happy to apply those patches as well.
> 
> I still think we'd need a fix for Bjorn's connector case though.
> Not sure I would be confident providing that one without the hardware
> to test with.
> 
> Bjorn, what do you think?
> 

I'm okay with the idea that it's up the driver to check that the output
port references an usb-c-connector - either before the call or upon
drm_of_find_panel_or_bridge() returning an error.

Regards,
Bjorn
