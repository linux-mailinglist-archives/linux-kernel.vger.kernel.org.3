Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495DB4D38A8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbiCISXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbiCISXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:23:22 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305DC574BF;
        Wed,  9 Mar 2022 10:22:23 -0800 (PST)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KDLBS6h5Vz67SnY;
        Thu, 10 Mar 2022 02:21:52 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Wed, 9 Mar 2022 19:22:21 +0100
Received: from localhost (10.47.72.217) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 9 Mar
 2022 18:22:20 +0000
Date:   Wed, 9 Mar 2022 18:22:17 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <gregkh@linuxfoundation.org>, <rafael.j.wysocki@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
Subject: Re: [PATCH 03/11] cxl/core: Remove cxl_device_lock()
Message-ID: <20220309182217.00006bf5@Huawei.com>
In-Reply-To: <164610294604.2682974.11169622387063183603.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164610294604.2682974.11169622387063183603.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.72.217]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
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

On Mon, 28 Feb 2022 18:49:06 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for moving lockdep_mutex nested lock acquisition into the
> core, remove the cxl_device_lock() wrapper, but preserve
> cxl_lock_class() that will be used to inform the core of the subsystem's
> lock ordering rules.
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Makes sense, but perhaps the description should call out that after
this patch it's not just a wrapper remove, but rather the lock
checking is totally gone for now?

Otherwise this looks fine to me. FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
