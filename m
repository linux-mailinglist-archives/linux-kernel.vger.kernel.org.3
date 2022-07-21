Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050C857C7FE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbiGUJsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiGUJsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:48:04 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23BA814B1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:48:03 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2165622175;
        Thu, 21 Jul 2022 11:48:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1658396882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AofoZ+Awy4KTTKs9IfzgAqyAOXi1iBgYwBCmm4WFRPs=;
        b=dlLztd5srxat/ijNxxPXIYfY+0NC6DAtlpp/3+6XbPqmj2TJjWl5kVZAdhnPxqHaYIub0n
        F5vMOeR/ICItBFd2kXbai14WnR56BwzHOmNsH6TW9qz9uYYI7AkT7VX+e3MKuRHKcm+xyc
        38VqytfQSE0uKzWWrfLrq1X9OCDkJoQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Jul 2022 11:48:02 +0200
From:   Michael Walle <michael@walle.cc>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, p.yadav@ti.com, richard@nod.at,
        tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH 5/6] mtd: spi-nor: add generic flash driver
In-Reply-To: <202205132220.uRTFaqNA-lkp@intel.com> (raw)
References: <20220513133520.3945820-6-michael@walle.cc>
 <202205132220.uRTFaqNA-lkp@intel.com> (raw)
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e6b22ad3b427770625aa56a4fe700e5c@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> +
>> +	/* Fallback to a generic flash described only by its SFDP data. */
>> +	if (!info) {
>> +		ret = spi_nor_check_sfdp_signature(nor);
>> +		if (!ret)
>> +			info = &spi_nor_generic_flash;
>> +	}
> 
> May be this can be combined as
> 
>  	if (!info && (!spi_nor_check_sfdp_signature(nor)))
> 		info = &spi_nor_generic_flash;

While this is the behavior, I don't like (1) calling functions
in the condition and (2) rely on the && and || semantics, i.e.
to just call the second part if the first is true/false.

-michael
