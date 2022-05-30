Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBA2537926
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbiE3KfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiE3KfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:35:08 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C83A63BDE
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 03:35:07 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U7BcIt005120;
        Mon, 30 May 2022 05:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=GzhyoGx51XkZ9Mo3yhwG2V/CjnZBylrKcAb8Wsb0AU8=;
 b=GcHNGFl0pZZOMvptLaW9tCAD6pcRDHpIlPTZg8delS0F0HJBwukNRnMzOSy5vDQnoSz+
 DQwsxwyWUdlWgMFcJfDcnlF7QP+/PpQrDZR2+7biV/yNNdryTf/1QfUSb5Oi0l+e2zSs
 bLnNs62iqnX8Qr57MB3usJe4RWcwckMijBcdR8iFQP40p+9V4l35IqZh5J4L70f+2G6b
 FKlAs+z2ijuW01Cw4KkhLUWjUZU5JqgCgpWAw+nF6uFGB6XbHMXPGavdjaFOOySD72+r
 2wN0sWPENalzHps4xD5+Cw76fNeLui7fN/B0Zwm2+3EkjTzvKK6v4ntT5ER+2DR4jtyD Ng== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gbg5nhn79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 May 2022 05:34:22 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 30 May
 2022 11:34:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 30 May 2022 11:34:21 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6FD2411D1;
        Mon, 30 May 2022 10:34:15 +0000 (UTC)
Date:   Mon, 30 May 2022 10:34:15 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/17] ALSA: hda: cirrus: Add initial DSP support and
 firmware loading
Message-ID: <20220530103415.GU38351@ediswmail.ad.cirrus.com>
References: <20220525131638.5512-1-vitalyr@opensource.cirrus.com>
 <871qwf0x8t.wl-tiwai@suse.de>
 <20220530090846.GS38351@ediswmail.ad.cirrus.com>
 <87czfvxtsc.wl-tiwai@suse.de>
 <20220530093639.GT38351@ediswmail.ad.cirrus.com>
 <87a6azxr7h.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87a6azxr7h.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: -lN94J1CuJ_EtnbX0lK0T_eaHPkE3bhG
X-Proofpoint-GUID: -lN94J1CuJ_EtnbX0lK0T_eaHPkE3bhG
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 12:14:26PM +0200, Takashi Iwai wrote:
> On Mon, 30 May 2022 11:36:39 +0200,
> Charles Keepax wrote:
> > On Mon, May 30, 2022 at 11:18:43AM +0200, Takashi Iwai wrote:
> > > On Mon, 30 May 2022 11:08:46 +0200,
> > > Charles Keepax wrote:
> > > > On Fri, May 27, 2022 at 06:13:38PM +0200, Takashi Iwai wrote:
> > > > > On Wed, 25 May 2022 15:16:21 +0200,
> > > > > Vitaly Rodionov wrote:
> > Yeah that should be what is happening here. Although it looks
> > like this code might be removing all the controls if the firmware
> > is unloaded. I will discuss that with the guys, we normal just
> > disable the controls on the wm_adsp stuff.
> 
> OK, that sounds good.  Basically my concern came up from the code
> snippet doing asynchronous addition/removal via work.  This showed
> some yellow signal, as such a pattern doesn't appear in the normal
> implementation.  If this is (still) really necessary, it has to be
> clarified as an exception.
> 

Hm... ok we will think about that. I think that part will
probably still be necessary. Because there is an ALSA control
that selects the firmware, then it is necesarry to defer creating
the controls to some work, since you are already holding the
lock.

I guess we could look at adding locked versions of the add
control functions as well if that might be preferred?

Thanks,
Charles
