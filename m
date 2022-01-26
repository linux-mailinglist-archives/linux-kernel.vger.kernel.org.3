Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F2149C545
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbiAZIaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiAZIaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:30:21 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F8DC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 00:30:21 -0800 (PST)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1nCdgw-00017u-RR; Wed, 26 Jan 2022 09:30:10 +0100
Date:   Wed, 26 Jan 2022 09:30:10 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] staging: r8188eu: ODM_RF_CALIBRATION is always set
Message-ID: <20220126083010.g7cw77wcliydh3im@viti.kaiser.cx>
References: <20220122170547.68378-1-martin@kaiser.cx>
 <20220122170547.68378-4-martin@kaiser.cx>
 <20220126074917.GW1951@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126074917.GW1951@kadam>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thus wrote Dan Carpenter (dan.carpenter@oracle.com):

> On Sat, Jan 22, 2022 at 06:05:46PM +0100, Martin Kaiser wrote:
> > @@ -36,10 +35,6 @@ static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
> >  	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_MP_TEST_CHIP, IS_NORMAL_CHIP(hal_data->VersionID));

> >  	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_RF_ANTENNA_TYPE, hal_data->TRxAntDivType);
> > -
> > -	pdmpriv->InitODMFlag =	ODM_RF_CALIBRATION;
> > -
> > -	ODM_CmnInfoUpdate(dm_odm, ODM_CMNINFO_ABILITY, pdmpriv->InitODMFlag);

> Wait, why did you remove the ODM_CmnInfoUpdate()?

I removed the last item that Init_ODM_ComInfo_88E added to
pdmpriv->InitODMFlag. Init_ODM_ComInfo_88E does no longer modify
pdmpriv->InitODMFlag, there's no need for updating the odm internal
status.

Best regards,

   Martin
