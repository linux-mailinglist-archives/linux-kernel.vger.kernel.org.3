Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179A44EAE11
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbiC2NEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbiC2NEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:04:35 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912A6DD941;
        Tue, 29 Mar 2022 06:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1648558972; x=1680094972;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nA1tDhQT6yyz0RCW/ZAbYtMlxzToy1jJLePTdKpjnYM=;
  b=oDHuceZ/vjo93yXfvzAbsOuQPoKCrdeEoq0QmV50kHgvcprZf9Pk3xub
   c3CV/CEV2eMjfUelWkSI8sB13mRm9On90kpLyPX4Svs8lyGaWmYI1bNyy
   6YEKMVmRZsojeYad6Cz4uUSiKn67M+pB2XfX+9iX91Tcw3ahSFC3piolB
   JRcovG/bS+PrN8gm5mzj9zeABiGcyxd5ymG7a8H4g3NatIO/urbZSZXJH
   n8sf/K2lFSnMxk7/sVOSfxzhtG5CmRAF9QxkC6Yq1HzBjeIr6cmgnc5wx
   Xkj5zFdeVLjBNCNSiJg9uhLAbUFLKg7eVu/4Qi24h7D74fnrL0ZsArBwO
   w==;
X-IronPort-AV: E=Sophos;i="5.90,220,1643670000"; 
   d="scan'208";a="22962188"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 29 Mar 2022 15:02:49 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 29 Mar 2022 15:02:49 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 29 Mar 2022 15:02:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1648558969; x=1680094969;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nA1tDhQT6yyz0RCW/ZAbYtMlxzToy1jJLePTdKpjnYM=;
  b=As1uN9JROmXcNreoIDglAbHKFLD1R42QzLHMevUhrgVGzEVOoqFqyddb
   M4m2XFBNSqwJd/UoBYFE5VG0DowQIEDTWTXUC/KJxF+UpgTHkQxJBQoDC
   vEkpC1v7PEtGKNus33mu4NdsuOiDQOIN73ghYo5snVEENwTn0aYV+nM/r
   Lhcnm6Gp8uE6SLvBQFrvslFP6zkGRNBsVDxWm2kQ5Y7/6ZEzbt0MPtKKB
   Ae6nIDtDHrGq1/shqVoTxm0eNNLrPQV9UDSebazO+4lYHLpbOISfwAnG4
   b9bmNuhU4kP7kGRHQ/7J9AStRFtksygXt+SOEJS1Su9Jmk+lh2bs5G0Bx
   g==;
X-IronPort-AV: E=Sophos;i="5.90,220,1643670000"; 
   d="scan'208";a="22962187"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 29 Mar 2022 15:02:49 +0200
Received: from schifferm-ubuntu (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 31175280065;
        Tue, 29 Mar 2022 15:02:49 +0200 (CEST)
Message-ID: <82266d339e09ad16963e16014cd836fa670b3a0c.camel@ew.tq-group.com>
Subject: RE: [PATCH] serial: Revert RS485 polarity change on UART open
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Lukas Wunner <lukas@wunner.de>
Date:   Tue, 29 Mar 2022 15:02:48 +0200
In-Reply-To: <749eee7dd2c7464a8c4d9ea5972205fa@AcuMS.aculab.com>
References: <20220329085050.311408-1-matthias.schiffer@ew.tq-group.com>
         <20220329100328.GA2090@wunner.de>
         <b2f29129f966685105e09781620b85c8f4f1a88e.camel@ew.tq-group.com>
         <749eee7dd2c7464a8c4d9ea5972205fa@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-03-29 at 12:55 +0000, David Laight wrote:
> From: Matthias Schiffer
> > Sent: 29 March 2022 11:39
> ...
> > I guess that would work. The fact that even the different
> > variants of the 8250 are implemented inconsistently makes this
> > especially ugly... It certainly puts a damper on the efforts to
> > make
> > the handling of RS485 in serial drivers more generic.
> 
> One thing to remember is that RS232 (IIRC really V.38) line driver
> chips are typically inverting.
> 
> So the modem signals on a TTL level output will have the
> opposite polarity to that required on the actual connector.
> 
> Normally a UART will have an 'active high' register bit for
> a modem signal that drives and 'active low' pin so you get
> the correct polarity with an inverting line driver.
> 
> 	David
> 

Indeed. As far as I can tell, this property of UARTs is what got us
into this mess: Some people interpreted SER_RS485_RTS_ON_SEND as "set
the RTS flag in the MCR register on send", while other thought it
should mean "set the RTS pin to high on send", leading to opposite
behaviours in different UART drivers (and even different UART variants
in the same driver, in the case of the 8250 family).

Regards,
Matthias

