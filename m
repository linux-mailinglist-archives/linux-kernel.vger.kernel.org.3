Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E91E49DFB7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbiA0KrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:47:23 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44620 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239427AbiA0KrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:47:21 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20RAlFGC028812;
        Thu, 27 Jan 2022 04:47:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643280435;
        bh=uwjrtnwGRUEvw3eaeYWL6vNWKxxgyzwh/N+ZOYzV9Kg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=crn5Wq0pOm++Rr2JbB0VkdHRgxIRPAtV2OD/Nk68kLVouSGMHTdNQxWvHgE/Q/+sq
         APiWU5GVYfx0sr6+cXdMns0Qn43sOxVSgg1gZV3ufeQHANk9CvZAJ3e4AufdX5R8fe
         4sqcg/2I3x1NbhYomi6UOCj0PNx5UEvGYKtuGW5g=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20RAlFaL121912
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jan 2022 04:47:15 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 27
 Jan 2022 04:47:13 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 27 Jan 2022 04:47:13 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20RAlCDI024833;
        Thu, 27 Jan 2022 04:47:13 -0600
Date:   Thu, 27 Jan 2022 16:17:12 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Zhou Qingyang <zhou1615@umn.edu>
CC:     <kjlu@umn.edu>, Benoit Parrot <bparrot@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: ti-vpe: cal: Fix a NULL pointer dereference in
 cal_ctx_v4l2_init_formats()
Message-ID: <20220127104712.sg444qsdittl2kse@ti.com>
References: <20220124172001.62457-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220124172001.62457-1-zhou1615@umn.edu>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/22 01:20AM, Zhou Qingyang wrote:
> In cal_ctx_v4l2_init_formats(), devm_kzalloc() is assigned to fw and there
> is a dereference of it after that, which could lead to NULL pointer
> dereference on failure of devm_kzalloc().
> 
> Fix this bug by adding a NULL check of ctx->active_fmt.
> 
> This bug was found by a static analyzer.
> 
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: 7168155002cf ("media: ti-vpe: cal: Move format handling to cal.c and expose helpers")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
