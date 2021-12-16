Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1B2476D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbhLPJ3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:29:19 -0500
Received: from bosmailout07.eigbox.net ([66.96.185.7]:40863 "EHLO
        bosmailout07.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbhLPJ3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:29:17 -0500
X-Greylist: delayed 1835 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Dec 2021 04:29:16 EST
Received: from bosmailscan01.eigbox.net ([10.20.15.1])
        by bosmailout07.eigbox.net with esmtp (Exim)
        id 1mxmb1-0002Bn-Bd; Thu, 16 Dec 2021 03:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ewhac.org;
         s=dkim; h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bHYYfQ4Cj+cqneseigspjoQQhJPicbxi/z8SoMuQsiE=; b=xPlYxW7uM7xjoJlpWF94xb/El/
        8YwQg1jrjp8FrFecBKoVGho7F+vE/3HbWDlD+eSuwZz8/RZWwAe0YMmxW6a1QVt2m4BgwO0ZpAs9c
        6flnC6PVc07gmelquGjpoa6uWBniE/BdEokbz2rs1mg2Gx06zlMSStQlAtsPiEAg4ZrA4+8ndrolQ
        YPEbY+zI+TQgaPfWj2kRmwOJYv4ffUFcl2Xnwz0Xacj1+C+eBjBDiWubey1Jzc1NmzW7K6uXAfvpV
        +iIY9s7czIMwpUNDo0DgjRo8n9h2HZPZpNgplv7u7w2dBEuROKrmRthlkeaOV+m7g2BvgiTcE7zaY
        SEqYSaIA==;
Received: from [10.115.3.33] (helo=bosimpout13)
        by bosmailscan01.eigbox.net with esmtp (Exim)
        id 1mxmb0-00053n-W8; Thu, 16 Dec 2021 03:58:39 -0500
Received: from bosauthsmtp19.yourhostingaccount.com ([10.20.18.19])
        by bosimpout13 with 
        id Wwyb260090QhFXN01wyeyX; Thu, 16 Dec 2021 03:58:38 -0500
X-Authority-Analysis: v=2.3 cv=RNUo47q+ c=1 sm=1 tr=0
 a=9UqFsMnAB6EOkiq4MrOclQ==:117 a=lOZ7gjDonWBvovu+dU3iMA==:17
 a=kj9zAlcOel0A:10 a=IOMw9HtfNCkA:10 a=ltsmEuTAGloA:10 a=fmD_JHji_u0A:10
 a=fYNHH8dQZQOtrz4ChQEA:9 a=CjuIK1q_8ugA:10 a=Ixuhb_GfD2BeaOSowo0a:22
 a=HH7FIXwXL_sUf1zzYxQd:22
Received: from [135.180.175.56] (port=34520 helo=walkies.ewhac.org)
        by bosauthsmtp19.eigbox.net with esmtpa (Exim)
        id 1mxmax-0008Ou-Oa; Thu, 16 Dec 2021 03:58:35 -0500
Received: from ewhac by walkies.ewhac.org with local (Exim 4.95)
        (envelope-from <ewhac@ewhac.org>)
        id 1mxmaw-001eaX-I0;
        Thu, 16 Dec 2021 00:58:34 -0800
Date:   Thu, 16 Dec 2021 00:58:34 -0800
From:   "Leo L. Schwab" <ewhac@ewhac.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: spaceball - fix parsing of movement data packets
Message-ID: <Ybr/uvSVd/TSwuNM@ewhac.org>
References: <20210727040625.2159196-1-ewhac@ewhac.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727040625.2159196-1-ewhac@ewhac.org>
X-EN-UserInfo: a76222b247b80e113a63936ffdc903eb:931c98230c6409dcc37fa7e93b490c27
X-EN-AuthUser: ewhac@ewhac.org
Sender:  "Leo L. Schwab" <ewhac@ewhac.org>
X-EN-OrigIP: 135.180.175.56
X-EN-OrigHost: unknown
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 09:06:24PM -0700, Leo L. Schwab wrote:
> The spaceball.c module was not properly parsing the movement reports
> coming from the device.  [ ... ]

	Um...  Ping?  This issue still exists, and it's been around a really
long time.  I've been using this patch to successfully fly around QuakeWorld
for several months now.

					Schwab
