Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAE04B07B3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbiBJIBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:01:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbiBJIBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:01:44 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220121088
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:01:44 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 924112223A;
        Thu, 10 Feb 2022 09:01:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644480101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f/wqfZ7Tr1j9aSdCRb6UxeY6aGR1bPLimuxomNP4AWQ=;
        b=DIkgjIue5Cuw5V1TANoCyK23hr+AMqR+LeQLRZd5aglf77JppssV8wm8LBHnvv5akISPrd
        xjHkI/PRZ7Zo7I7Erxswr67nxpdG4pymxpkolZCsGNnphd3W9Y15lsAvQR8SXwbKLsufsZ
        0PIx1UjLjieWSA6Dx6wxMNgflIisecY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Feb 2022 09:01:39 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Subject: Re: [PATCH v1 02/14] mtd: spi-nor: slightly refactor the
 spi_nor_setup()
In-Reply-To: <f4a7a2c2-579c-f558-3d85-cf0709a6060c@microchip.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-3-michael@walle.cc>
 <f4a7a2c2-579c-f558-3d85-cf0709a6060c@microchip.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <0280538304fe8c837af0356ae469f428@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-02-10 04:00, schrieb Tudor.Ambarus@microchip.com:
> On 2/2/22 16:58, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Instead of always using a function pointer (and initializing it to our
>> default), just call the default function if the flash didn't set its 
>> own
>> one. That will make the call flow easier to follow.
>> 
>> Also mark the parameter as optional now.
> 
> what should be done in the future?

What do you mean? IMHO the default path should be visible in the
function. Eg.

int spi_nor_bla(nor) {
     if (nor->some_exceptional_cb)
         return nor->some_exceptional_cb(nor);

    return usual_cb(nor);
}

-michael
