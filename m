Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D18587E32
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbiHBOey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbiHBOew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:34:52 -0400
X-Greylist: delayed 8611 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 Aug 2022 07:34:51 PDT
Received: from mx0a-00176a03.pphosted.com (mx0b-00176a03.pphosted.com [67.231.157.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB47A140F0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 07:34:51 -0700 (PDT)
Received: from pps.filterd (m0048300.ppops.net [127.0.0.1])
        by m0048300.ppops.net-00176a03. (8.17.1.5/8.17.1.5) with ESMTP id 2724foPR047712
        for <linux-kernel@vger.kernel.org>; Tue, 2 Aug 2022 08:11:19 -0400
Date:   Tue, 2 Aug 2022 15:04:04 +0300
From:   Ian Ray <ian.ray@ge.com>
To:     Martyn Welch <martyn.welch@collabora.co.uk>
Cc:     Zheyu Ma <zheyuma97@gmail.com>, peter.senna@gmail.com,
        andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: megachips: Fix a null pointer dereference bug
Message-ID: <20220802120403.GA26182@zoo6.em.health.ge.com>
References: <20220716081304.2762135-1-zheyuma97@gmail.com>
 <946c008942f4ef4ca642818b23e9941c162383e3.camel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <946c008942f4ef4ca642818b23e9941c162383e3.camel@collabora.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: L3lyOPfwkbkATPxXkRb97PUKWosNoM8H
X-Proofpoint-GUID: L3lyOPfwkbkATPxXkRb97PUKWosNoM8H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_07,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 clxscore=1011 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208020056
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 09:38:16AM +0100, Martyn Welch wrote:
> On Sat, 2022-07-16 at 16:13 +0800, Zheyu Ma wrote:
> > When removing the module we will get the following warning:
> > 
> > [   31.911505] i2c-core: driver [stdp2690-ge-b850v3-fw] unregistered
> > [   31.912484] general protection fault, probably for non-canonical
> > address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
> > [   31.913338] KASAN: null-ptr-deref in range [0x0000000000000008-
> > 0x000000000000000f]
> > [   31.915280] RIP: 0010:drm_bridge_remove+0x97/0x130
> > [   31.921825] Call Trace:
> > [   31.922533]  stdp4028_ge_b850v3_fw_remove+0x34/0x60
> > [megachips_stdpxxxx_ge_b850v3_fw]
> > [   31.923139]  i2c_device_remove+0x181/0x1f0
> > 
> > The two bridges (stdp2690, stdp4028) do not probe at the same time,
> > so
> > the driver does not call ge_b850v3_resgiter() when probing, causing
> > the
> > driver to try to remove the object that has not been initialized.
> > 
> > Fix this by checking whether both the bridges are probed.
> > 
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> 
> Good catch!
> 
> Acked-by: Martyn Welch <martyn.welch@collabora.com>

Tested-by: Ian Ray <ian.ray@ge.com>


> 
> Would be worth adding:
> 
> Fixes: 11632d4aa2b3 ("drm/bridge: megachips: Ensure both bridges are
> probed before registration")
> 
> > ---
> >  drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > index cce98bf2a4e7..c68a4cdf4625 100644
> > --- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > +++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > @@ -296,7 +296,9 @@ static void ge_b850v3_lvds_remove(void)
> >          * This check is to avoid both the drivers
> >          * removing the bridge in their remove() function
> >          */
> > -       if (!ge_b850v3_lvds_ptr)
> > +       if (!ge_b850v3_lvds_ptr ||
> > +               !ge_b850v3_lvds_ptr->stdp2690_i2c ||
> > +               !ge_b850v3_lvds_ptr->stdp4028_i2c)
> >                 goto out;
> >  
> >         drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);
> 
