Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0C949DF0F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbiA0KUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiA0KUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:20:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF60C061714;
        Thu, 27 Jan 2022 02:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YUUBevVBgRoXIADyQTeoZhGAF340Wfzy2ybkVfz5WH8=; b=d4kdl6DLH52H0H3bXI8/YNWsGi
        gKbeDvgr5J1uEWXqANQ0xwiVtqWSPvBSU25MeYFlD8JgijoWOtNO27ZBDM1qyrdxBCek8Br+A+yYd
        GH/hhu2RUqhrtQoqJ0+flbQYGKJtUwRCd0x9juxU4yanRGopRDwQ7g/KEDkzdX1POTfovVdfjHIS7
        4C+mVVUrbE6Ex1sjj69Zd3P3rNajRAOZBBUJgX2MgN5yjmKXHLwEg/cE4erYGSkPYruMPRTCS+a9q
        VjWdcjRzlsSZuZsY6EMl63ZNQpUA1HRNgHkpQUDlgFZpL7TFodsSP5L2AqZle+Emv4MwRg/uzo9n8
        lAxP48kg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD1sk-00F84i-83; Thu, 27 Jan 2022 10:19:58 +0000
Date:   Thu, 27 Jan 2022 02:19:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        artur.paszkiewicz@intel.com, jinpu.wang@cloud.ionos.com,
        chenxiang66@hisilicon.com, Ajish.Koshy@microchip.com,
        yanaijie@huawei.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, liuqi115@huawei.com, Viswas.G@microchip.com,
        damien.lemoal@opensource.wdc.com
Subject: Re: [PATCH 01/16] scsi: libsas: Use enum for response frame DATAPRES
 field
Message-ID: <YfJxzi1udZQhAYKW@infradead.org>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1643110372-85470-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643110372-85470-2-git-send-email-john.garry@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 07:32:37PM +0800, John Garry wrote:
> -	if (iu->datapres == 0)
> +	if (iu->datapres == NO_DATA)
>  		tstat->stat = iu->status;
> -	else if (iu->datapres == 1)
> +	else if (iu->datapres == RESPONSE_DATA)
>  		tstat->stat = iu->resp_data[3];
> -	else if (iu->datapres == 2) {
> +	else if (iu->datapres == SENSE_DATA) {

Maybe use a switch here to make it more obvious?
