Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB18A4CEC39
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 17:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiCFQZq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 6 Mar 2022 11:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiCFQZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 11:25:45 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAB73EBB6
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 08:24:52 -0800 (PST)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KBRkQ1S5Qz67Gvv;
        Mon,  7 Mar 2022 00:24:30 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 17:24:49 +0100
Received: from localhost (10.47.64.190) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sun, 6 Mar
 2022 16:24:49 +0000
Date:   Sun, 6 Mar 2022 16:24:43 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Wei WANG <wei_wang@realsil.com.cn>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH -next] misc: rtsx: fix build for CONFIG_PM not set
Message-ID: <20220306162443.00006a0d@Huawei.com>
In-Reply-To: <20220306151212.00003e6f@Huawei.com>
References: <20220226222457.13668-1-rdunlap@infradead.org>
        <CAK8P3a07PoFGC8jyRG5_CjfVPCc2T79c7Fs_WmHZEkuqtG+oPg@mail.gmail.com>
        <449d6ceb-7308-9543-c23c-831bebffda21@infradead.org>
        <CAK8P3a30RbSk3Y5CyRrOjfTiq0c9XGxC3qjAD0154j3a7k+xQQ@mail.gmail.com>
        <0D5Z7R.NUOWBMRT4GQ2@crapouillou.net>
        <CAK8P3a3=5uud3jd7N3FEAnaLapX-0OYaiscBFNEQm2hzkTmj7g@mail.gmail.com>
        <7U5Z7R.RNKITPUWCPX32@crapouillou.net>
        <20220306151212.00003e6f@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.64.190]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Mar 2022 15:12:12 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Sun, 27 Feb 2022 17:56:31 +0000
> Paul Cercueil <paul@crapouillou.net> wrote:
> 
> > Le dim., févr. 27 2022 at 18:51:38 +0100, Arnd Bergmann 
> > <arnd@arndb.de> a écrit :  
> > > On Sun, Feb 27, 2022 at 6:46 PM Paul Cercueil <paul@crapouillou.net> 
> > > wrote:    
> > >>  Le dim., févr. 27 2022 at 18:30:16 +0100, Arnd Bergmann
> > >> 
> > >>  There could be a DEFINE_DEV_PM_OPS(), but I don't think that's 
> > >> really
> > >>  needed - you can very well declare your struct dev_pm_ops without 
> > >> using
> > >>  one of these macros. Just make sure to use the SYSTEM_SLEEP_PM_OPS /
> > >>  RUNTIME_PM_OPS macros for the callbacks and pm_ptr() for the 
> > >> device.pm
> > >>  pointer.    
> > > 
> > > Ah, of course, so it comes down to
> > > s/SET_SYSTEM_SLEEP_PM_OPS/SYSTEM_SLEEP_PM_OPS/ while
> > > removing all the #ifdef an __maybe_unused annotations. The pm_ptr()
> > > in driver.pm makes this slightly more optimized AFAICT, but has no
> > > effect on behavior, right?    
> > 
> > The use of SYSTEM_SLEEP_PM_OPS makes sure that the callbacks are 
> > dropped if the dev_pm_ops is dead code, and the pm_ptr() must be used 
> > for the compiler to know that the dev_pm_ops is dead code.
> > 
> > -Paul
> > 
> >   
> 
> Hi Paul,
> 
> We have one remaining case which is still ugly to do.
> Where both SYSTEM_SLEEP_PM_OPS/RUNTIME_PM_OPS are set and
> the dev_pm_ops structure is exported.
> 
> For that one we still need to expose #ifdef fun in the
> drivers I think.
> 
> Any suggestions on a clean solution for that?
> 
> Currently I have this...
> 
> #ifdef CONFIG_PM
> const struct dev_pm_ops bmc150_magn_pm_ops = {
> 	SYSTEM_SLEEP_PM_OPS(...)
> 	RUNTIME_PM_OPS(...)
> };
> EXPORT_SYMBOL_NS(bmc150_magn_pm_ops, IIO_BMC150_MAGN);
> #else
> static const __maybe_unused dev_pm_ops bmc150_magn_pm_ops = {
With this renamed to dummy_bmc150_magn_pm_ops to avoid
the previous declared warning I'll otherwise get. oops.
> 	SYSTEM_SLEEP_PM_OPS(...)
> 	RUNTIME_PM_OPS(...)
> };
> #endif
> Not super clean but perhaps we do need
> EXPORT_NS_DEV_PM_OPS
> EXPORT_NS_GPL_DEV_PM_OPS
> and potentially the non namespaced versions.
> 
> Thanks,
> 
> Jonathan

