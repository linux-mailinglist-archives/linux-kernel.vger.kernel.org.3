Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479EC5081A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359580AbiDTHGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352073AbiDTHGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:06:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BF039680;
        Wed, 20 Apr 2022 00:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sKpOz5kRNnXVlL8xIRzbyWEYT0p6tIybTkc57ttCiT8=; b=BOpMhj3pWD+N+K4Wpk8pbBgZEN
        vvnsq3ppSmprrtZZ6oNnoNKt/iSx4dZnrceMxaPBZdeugeN5hLBqyO42UDjul6ydO/UjANTrgApRx
        5bZG+ciGLhM+fQ2+bSzRmE6NOM3TFgnpqP8/M6jA+30XU5sy9ZQW27LOuLKn8APvqoopTP7vPPwFo
        XyMXAKZ2u+kFq0KgZhzr5jwHOH9zrEffNIGcy2WBUcEVFwRGbPvC3XJHUXw2QvsnIAFVEpd45Odjh
        NcAbFAov4p8gRJ8q7qZ7NnLWUa6OqDZjNMKEa5ZxOuvme1JcCsjUSL19r11NjoWP59ePmu+GGZRQN
        PT/CiGtg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh4Mh-007g4K-II; Wed, 20 Apr 2022 07:03:03 +0000
Date:   Wed, 20 Apr 2022 00:03:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Garry <john.garry@huawei.com>
Cc:     "Ewan D. Milne" <emilne@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.smart@broadcom.com
Subject: Re: [PATCH 1/4] scsi: core: constify pointer to scsi_host_template
Message-ID: <Yl+wJ7xSHzWmR+bR@infradead.org>
References: <20220408103027.311624-1-krzysztof.kozlowski@linaro.org>
 <2a88a992-641a-b3ff-fe39-7a61fff87cb6@huawei.com>
 <4c3be5b6-50ef-9e9a-6cee-9642df943342@linaro.org>
 <7b3885e3-dbae-ff0b-21dc-c28d635d950b@huawei.com>
 <c121430b1b5c8f5816b2b42b9178d00889260c90.camel@redhat.com>
 <b6af3fe8-db9a-b5dc-199f-21c05d7664a2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6af3fe8-db9a-b5dc-199f-21c05d7664a2@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 08:57:39AM +0100, John Garry wrote:
> > 
> 
> The standard flow is:
> 
> shost = scsi_host_alloc(sht, )
> 
> // modify shost, like
> shost->cmd_per_lun = 5;
> 
> scsi_add_host(shost)
> 
> Is there some reason for which those two drivers can't follow that?

I think they should.  Method tables should not be mutable data.
