Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57236522E69
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243981AbiEKIdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243779AbiEKIbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:31:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14273190F;
        Wed, 11 May 2022 01:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v6LTVQjeDFrw6vdK4w8luloTEFL+fsitDmR6W5fFJig=; b=IZ8CZmlPJlqOJneX1ygZtZH9XC
        3O4wLrlBJTUiSsQ7Wn4piNtq66RatOWmjhgxOKeLdSi/UU/ygJU2swRImRifc+taFT25hqRbjQX4Z
        oWxPzaMZOEUW6AYTlQ5v+wNTWmgeUfQvPh6nyxty8+fhr7S5FCw7n5qtRCWwtHpWC1mXbm/HwSjld
        ODjjNirmL4WaUSW+odUmMSpD2S3wa+stlWW94jiP+O6lgW0ixEbsQ8p2YgPFaCPIwwNSVSpmgkqV1
        ox4chKK7R/t5IycO3qu+lPIw1m+Opdn73RKY2cRGTuOMnM4qOIMqFuGnMMdE8ruXVY/iJdsxH+/kb
        9ytKpZlQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nohku-005xEt-Te; Wed, 11 May 2022 08:31:36 +0000
Date:   Wed, 11 May 2022 01:31:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Ewan D. Milne" <emilne@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.smart@broadcom.com
Subject: Re: [PATCH 1/4] scsi: core: constify pointer to scsi_host_template
Message-ID: <Ynt0aFMX+z/UhGJ2@infradead.org>
References: <c121430b1b5c8f5816b2b42b9178d00889260c90.camel@redhat.com>
 <b6af3fe8-db9a-b5dc-199f-21c05d7664a2@huawei.com>
 <Yl+wJ7xSHzWmR+bR@infradead.org>
 <d09faf74-a52e-8d93-cf26-08b43b12c564@huawei.com>
 <24bfb681-faec-3567-3089-9cd5ee182710@linaro.org>
 <1bb53912-c5c3-7690-e82f-cf356ca87404@huawei.com>
 <6f28acde-2177-0bc7-b06d-c704153489c0@linaro.org>
 <4510c5dc-3d7d-fc5f-cb80-34da7dbaaa8e@huawei.com>
 <d01c29c1-bb5a-281d-ef71-9c7b39e28d23@linaro.org>
 <fd2cdc06-5d88-306a-3ee1-7aef3e3b8921@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd2cdc06-5d88-306a-3ee1-7aef3e3b8921@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 03:50:33PM +0100, John Garry wrote:
> If you check scsi_device_dev_release(), we try to do a 'get' - if it fails,
> then we nullify hostt->module. I think that is important as then we call
> execute_in_process_context(), whose worker does the 'put'. However, the
> 'put' will get upset if the refcnt was 0, which it would be if the earlier
> 'get' fails - hence the nullify is to avoid that possibility. So whatever
> you do needs to handle that. Details are in f2b85040

Yikes, that code is completely and utterly buggy and does not account
for all the cases why try_module_get can fail.  I think we always have
a reference here and could use __module_get, but what we have is
certainly unsafe and a good reason why the host template should be
constifyed.
