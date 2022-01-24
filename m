Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6C8497CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiAXKMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiAXKMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:12:16 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC090C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 02:12:15 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id n23so10318066ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 02:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=00UDOHuVRkKKvQsjGUdxQd27cyZnJBr83FBriMmt9Gg=;
        b=bxMUTKscmSqHPkI0/AOrgAGs+hcPCMv+jTqRAwARzGbfal0wTRrbtmQAfb5oIur3SQ
         G+xTpHsNg9HTswIOMpCVpl5IQH6GjactMS685LLC4y4qQvhCG0x7iw7pAdqTtBwZIR+N
         T/7MmCtwUmtNX5wIjSL1EN6CK9OwJNwUqmgxeuqIcmPFhAxwzTl8+r4rkU+4Oh0ZWmmJ
         rOELz5uCkRo1PqCGZsLs9Bf40xeNYAHhY0C84kdToV+6M5NZL7idiVzGqRvFrW5rl4zT
         kwkpjusn/17wFVw6qnk1MGhWHeAfb2Rj0ePmHv+vdr5oJWADAL3TvF1OAt00Fp8yapKh
         tceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=00UDOHuVRkKKvQsjGUdxQd27cyZnJBr83FBriMmt9Gg=;
        b=Eb2uzaVQDkJA71KOOfGX6Y0atnC/NZ4YcQqJ6igSh+lpsPKpGWLdSsj/a2AWnUGTCV
         M+NQPsO3zaywvjW0yleBEP/mtr1EMQwNauju3HUU5UgpdmutBlkwtMc+8QZ7vsmFNDXO
         Oxr/Ac0Thrh5lo9A34kZgICUjA72I+qZJdz121Bo/PKfgAlNmCYlJ1qikkIg+/gHWdt/
         j5mSBooIYDDNa1KuTD87EfeY5s3uWvZeWibZXnSMeduumA5/KGzVqGai9YueeYafDz0P
         LkH3UeJ8z3xIQYCeuFWB7C3ZogRSNoWlGhNEn5uYwSUrl1wV10Q2mgQXPgdYzvKEGKDd
         qdGw==
X-Gm-Message-State: AOAM532882m7k0q20W+EVpEBKMNXobl1mZytl5QqrvCCw8SS5ttlGhGD
        YgtAH7RG3MysqyyaDiqWXtY=
X-Google-Smtp-Source: ABdhPJxfjS1VYnBLdfKECvD6iwAfMMAOkdH9CYrYxb2qOSDqEn/9khScfZRqL1SFqDOcd55h1xl3TA==
X-Received: by 2002:a2e:8786:: with SMTP id n6mr10845274lji.166.1643019134022;
        Mon, 24 Jan 2022 02:12:14 -0800 (PST)
Received: from DESKTOPMNL9DDQ (88-115-161-74.elisa-laajakaista.fi. [88.115.161.74])
        by smtp.gmail.com with ESMTPSA id m10sm1119339lfk.119.2022.01.24.02.12.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jan 2022 02:12:13 -0800 (PST)
From:   <zhi.wang.linux@gmail.com>
To:     "'Christoph Hellwig'" <hch@lst.de>,
        "'Wang, Zhi A'" <zhi.a.wang@intel.com>
Cc:     <intel-gfx@lists.freedesktop.org>,
        <intel-gvt-dev@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "'Jason Gunthorpe'" <jgg@nvidia.com>,
        "'Jani Nikula'" <jani.nikula@linux.intel.com>,
        "'Joonas Lahtinen'" <joonas.lahtinen@linux.intel.com>,
        "'Vivi, Rodrigo'" <rodrigo.vivi@intel.com>,
        "'Zhenyu Wang'" <zhenyuw@linux.intel.com>,
        "'Xu, Terrence'" <terrence.xu@intel.com>
References: <20211129123832.105196-1-zhi.a.wang@intel.com> <20211130164622.GA15150@lst.de> <e183b95f-89d1-3a2f-27e2-82aa2b10e8fc@intel.com> <20220124094004.GA23537@lst.de>
In-Reply-To: <20220124094004.GA23537@lst.de>
Subject: RE: [PATCH v4 1/2] i915/gvt: Introduce the mmio_info_table.c to support VFIO new mdev API
Date:   Mon, 24 Jan 2022 12:12:12 +0200
Message-ID: <004201d8110a$db3ec9e0$91bc5da0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHIPB7b9XYZUM7zLx+SfJYTBroPkAJO7v/TAoSMsnoBvpZ7zKxdDGRA
Content-Language: en-us
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph and Jason:

Have been talking with Raj. I am going to work on this series this week. 

Thanks,
Zhi.

-----Original Message-----
From: Christoph Hellwig <hch@lst.de> 
Sent: Monday, January 24, 2022 11:40 AM
To: Wang, Zhi A <zhi.a.wang@intel.com>
Cc: Christoph Hellwig <hch@lst.de>; Zhi Wang <zhi.wang.linux@gmail.com>;
intel-gfx@lists.freedesktop.org; intel-gvt-dev@lists.freedesktop.org;
dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; Jason
Gunthorpe <jgg@nvidia.com>; Jani Nikula <jani.nikula@linux.intel.com>;
Joonas Lahtinen <joonas.lahtinen@linux.intel.com>; Vivi, Rodrigo
<rodrigo.vivi@intel.com>; Zhenyu Wang <zhenyuw@linux.intel.com>; Xu,
Terrence <terrence.xu@intel.com>
Subject: Re: [PATCH v4 1/2] i915/gvt: Introduce the mmio_info_table.c to
support VFIO new mdev API

On Fri, Dec 17, 2021 at 08:52:53AM +0000, Wang, Zhi A wrote:
> Sorry for the late reply as I am supporting the customers recently. I 
> will refresh this after the christmas.

Did you find some time to look into it?  Do you want some help?

