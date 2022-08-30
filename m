Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9465A5ECF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiH3JAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiH3JAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:00:42 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2813D3D582
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:00:40 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27U6Tnpn015916;
        Tue, 30 Aug 2022 04:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=uRhx0qsItgHE0IAxKDqM89f+96sF81OK+0o/iFCcvgc=;
 b=cpI3qv8nZ3bz6aZFMMwF48lZRIKJ1bkMiyJRW/QvlydqTx+d8/Bgx7bZYaBmcR0pV6nB
 ZugUGNv/T97JqpSriapR7s80CF1aKOCpNrqegUxZ3L5AIq2iVcuRrDg3hI9pzBJEOHp2
 JCssrq1RcyWiaAa5szcooOLNFdOHUVNHyeD7tAIEzxkagiBk22lpxC6L6lXX+ppTzQcl
 wWn91ISG+vIyf0siIGiQgPC7yJnmOy1MNoIAkHlCSuwpxRBq5fr5d2hTkquN2IEXg6uJ
 d2Q9EjnEiUF/OKFKMoPMY4e5KuJ6p7BRaYdZwu6CeDteq80uzmEqYLO1hb436WpLyC6T hQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3j7fppb5b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 04:00:16 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Tue, 30 Aug
 2022 04:00:15 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Tue, 30 Aug 2022 04:00:15 -0500
Received: from [198.90.251.95] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CFC7F459;
        Tue, 30 Aug 2022 09:00:14 +0000 (UTC)
Message-ID: <b3162f04-5cfe-75c2-6117-d7949ccd0a5a@opensource.cirrus.com>
Date:   Tue, 30 Aug 2022 10:00:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/3] soundwire: bus: Fix lost UNATTACH when re-enumerating
Content-Language: en-US
To:     <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20220825122241.273090-1-rf@opensource.cirrus.com>
 <20220825122241.273090-4-rf@opensource.cirrus.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20220825122241.273090-4-rf@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kK2WzBMWuKoTtPqrw0Bpl2oY0_QG6cYL
X-Proofpoint-ORIG-GUID: kK2WzBMWuKoTtPqrw0Bpl2oY0_QG6cYL
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2022 13:22, Richard Fitzgerald wrote:
> Rearrange sdw_handle_slave_status() so that any peripherals
> on device #0 that are given a device ID are reported as
> unattached. The ensures that UNATTACH status is not lost.
> 
> Handle unenumerated devices first and update the
> sdw_slave_status array to indicate IDs that must have become
> UNATTACHED.
> 

Don't use this patch!
I found there's a race condition with the Cadence interrupts.
Use my alternative fix.
