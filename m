Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADA44D1E34
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348455AbiCHRLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiCHRLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:11:36 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0418136E1A;
        Tue,  8 Mar 2022 09:10:38 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 228BoqLg031707;
        Tue, 8 Mar 2022 18:10:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=selector1; bh=XzG/zTVw2euF6p0nfQidx3eU2qleO7oEmiQIU/vSMww=;
 b=oYbXxQdaMgmV7JT3H83RsSSX7c1UQsb3ZPEH5iyScDvk3d+ZqexIgHCRvPUSkdfSErV0
 eg9PtWlqggZoj5GeOLgbEs83+fJSa6a1mAjeB+vvekp7WW3XgfDBoaRLiqyxMRgVEfTf
 /4nDS9UfO5f/PokAQVUtNKkY07OH0yuj/ZCNkcxhBkocBAlVZf9csgS+y2GH4W6JrIRS
 AuF564DJJilikEgGWMVC/W1yprKE4PNDIk7UrkadGJVZDZ3tEteTJ/C0/WpusyhIHYW0
 oqGAUhwgiQ7XCGf2cT6ba5CnE5PSUlOVlf68mlnbZnBDgdiDK8S85kD0SjkVYDt+Pjry ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3em0342jt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 18:10:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4D84410002A;
        Tue,  8 Mar 2022 18:10:12 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BCEE523694E;
        Tue,  8 Mar 2022 18:10:12 +0100 (CET)
Received: from gnbcxd0016.gnb.st.com (10.75.127.51) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 8 Mar
 2022 18:10:12 +0100
Date:   Tue, 8 Mar 2022 18:10:05 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH v1 1/1] media: c8sectpfe: Clean up handling of
 *_buffer_aligned
Message-ID: <20220308171005.GA365233@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
References: <20220209182521.55632-1-andriy.shevchenko@linux.intel.com>
 <Yh+SjmGgSZGGaW/I@smile.fi.intel.com>
 <YicvJpTtICUFAvoe@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YicvJpTtICUFAvoe@smile.fi.intel.com>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_06,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

sorry for the delay.

Reviewed-by: Alain Volmat <alain.volmat@foss.st.com>

Regards,
Alain

On Tue, Mar 08, 2022 at 12:25:42PM +0200, Andy Shevchenko wrote:
> +Hans (see below).
> 
> On Wed, Mar 02, 2022 at 05:51:42PM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 09, 2022 at 08:25:21PM +0200, Andy Shevchenko wrote:
> > > There are a few cases where code is harder than needed to read.
> > > Improve those by:
> > > - dropping unnecessary castings (see note below)
> > > - use PTR_ALING() to be more explicit on what's going on there
> > > - use proper definitions instead of hard coded values
> > > 
> > > Note, dropping castings will allow to perform an additional check
> > > that type is not changed from void * to something else, e.g. u64,
> > > which may very well break the bitmap APIs.
> > 
> > Any comments on it?
> > Can it be applied?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
