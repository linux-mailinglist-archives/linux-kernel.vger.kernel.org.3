Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A277E4A400E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358111AbiAaKXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:23:08 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:57566 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1358119AbiAaKXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:23:02 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20V8u3mh010749;
        Mon, 31 Jan 2022 04:22:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=1LxMoGxnvs16zzdk3JQdyN+Uxz944Fqx8Dah0ipLXRo=;
 b=glXKKufiBp/JxUJepJd5gEsY8EHQQAAdeRFhdMZbt12ytRN01tghxWQk92N4o0FKUw39
 tsFUf7YZX0in4aSnoMvREX2TbDKcoTvI4PLbgPY6g0qbr1lmyuZZ3cqzc4OFl+Ccwd6w
 wVtKhed4RcFgOdXlh2VxvqdK5j64nNYMXX2HgijVe5MKUucG0xNux2dICSc/5CW4MVSB
 RMMFmK6vAx75gyq/jlUtDzOoBq+PRiF1isW+MLuDyyCmVLhwy73R3kWqb/vNAc4ranQD
 4Y1sNTQFmp9c8T4AHg/dVxHLQeiwh8J0GvSnd5s0P39igEaVCLXZyB0CLbg9ZVgAk0/6 Mw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dw3v6agwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 31 Jan 2022 04:22:50 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 31 Jan
 2022 10:22:48 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 31 Jan 2022 10:22:48 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8944CB0E;
        Mon, 31 Jan 2022 10:22:48 +0000 (UTC)
Date:   Mon, 31 Jan 2022 10:22:48 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-input@vger.kernel.org>
Subject: Re: [PATCH] Input: wm97xx: Simplify resource management
Message-ID: <20220131102248.GX18506@ediswmail.ad.cirrus.com>
References: <87dce7e80ea9b191843fa22415ca3aef5f3cc2e6.1643529968.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87dce7e80ea9b191843fa22415ca3aef5f3cc2e6.1643529968.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: Q45GjBQNoz-z6kcUdPSZxz0Ty83Mv4lK
X-Proofpoint-ORIG-GUID: Q45GjBQNoz-z6kcUdPSZxz0Ty83Mv4lK
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 09:06:36AM +0100, Christophe JAILLET wrote:
> Since the commit in the Fixes tag below, 'wm->input_dev' is a managed
> resource that doesn't need to be explicitly unregistered or freed (see
> devm_input_allocate_device() documentation)
> 
> So, remove some unless line of code to slightly simplify it.
> 
> Fixes: c72f61e74073 ("Input: wm97xx: split out touchscreen registering")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
