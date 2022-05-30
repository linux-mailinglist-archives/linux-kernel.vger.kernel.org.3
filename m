Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3F2537868
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbiE3Jh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbiE3JhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:37:14 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370A575231
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:37:10 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U7BcHP005120;
        Mon, 30 May 2022 04:36:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=bKYxbNoDM4nFff5z/xz7MZN4pi94siKAcbuwm7LZsXI=;
 b=MTyV2daKaf1XPM0ut6qXecvk8tqcJYCCf0pSocuqvTrRSSHosKwn71PCrLVHbYOVPEIh
 Z/blHKXVRAdusGxQ1RLCcZD1i7ehfsRaxWmRvpy3Tu10Oe1X0ALS/8zZ7dkRXiZT36zw
 JKB6nPgjZjBUYeoMfn89C8K7gmin0Qd+AZKGAAqeq7Uow6JCfxpz5CCbPVCiBiZwNWVz
 PKIkJK2MB3ekIhwairlV7SR5Rp4UuK4n2ht5lBoTpMxvMFUEiyV4eJX7LsN0eI7pgm9Q
 e8gXu2KtOQb0AOcrpbAa5o1VPR8vLoYPyJfAKfNKrsqMSsA9tWX/1gwrNQUN7Y7lBCQG XA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gbg5nhkwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 May 2022 04:36:40 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 30 May
 2022 10:36:39 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 30 May 2022 10:36:39 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1AE57468;
        Mon, 30 May 2022 09:36:39 +0000 (UTC)
Date:   Mon, 30 May 2022 09:36:39 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/17] ALSA: hda: cirrus: Add initial DSP support and
 firmware loading
Message-ID: <20220530093639.GT38351@ediswmail.ad.cirrus.com>
References: <20220525131638.5512-1-vitalyr@opensource.cirrus.com>
 <871qwf0x8t.wl-tiwai@suse.de>
 <20220530090846.GS38351@ediswmail.ad.cirrus.com>
 <87czfvxtsc.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87czfvxtsc.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: HZLJ07Ac1ZXEmC-ipJehlWyWwDW3SLbV
X-Proofpoint-GUID: HZLJ07Ac1ZXEmC-ipJehlWyWwDW3SLbV
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 11:18:43AM +0200, Takashi Iwai wrote:
> On Mon, 30 May 2022 11:08:46 +0200,
> Charles Keepax wrote:
> > 
> > On Fri, May 27, 2022 at 06:13:38PM +0200, Takashi Iwai wrote:
> > > On Wed, 25 May 2022 15:16:21 +0200,
> > > Vitaly Rodionov wrote:
> > > The idea to add / delete controls by the control element change
> > > doesn't sound good; as already mentioned in my reply to the previous
> > > patch set, the change of the control elements can be triggered too
> > > easily by any normal users who have the access to the sound devices.
> > > It means thousands of additions and removals per second could be
> > > attacked by any user.
> > > 
> > 
> > This I am a little less sure how we handle. I mean arn't there
> > already a few ways to do this? Both the existing ASoC wm_adsp
> > stuff, and the topology stuff (used on all new Intel platforms,
> > so very widely deployed) let you create controls by loading a
> > firmware file. Also within ALSA itself can't user-space create
> > user ALSA controls? Is there some rate limiting on that? How is
> > this issue tackled there?
> 
> The creation of kctls via firmware loading would be OK, as the code
> path can't be triggered so frequently.  Is it the case for this patch
> set?  There was too little information about the implementation (and
> more importantly, how to use the controls), so it's hard to judge...
> 

Yeah that should be what is happening here. Although it looks
like this code might be removing all the controls if the firmware
is unloaded. I will discuss that with the guys, we normal just
disable the controls on the wm_adsp stuff.

Thanks,
Charles
