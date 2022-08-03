Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F6C5888A7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 10:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbiHCIUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 04:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbiHCIUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 04:20:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D86324;
        Wed,  3 Aug 2022 01:20:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A29CAB8218A;
        Wed,  3 Aug 2022 08:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1EDC433D6;
        Wed,  3 Aug 2022 08:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659514809;
        bh=YTKBls9eGthC9FqRXqmJxsRWecaguvJ9umgSjOD48gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E9ihXI5qgRx+iwX4ZqkQzq8Z4FJaMbi6I2DwIeKrJUxmWMWoLp2a+Qf8jQWrdXnKG
         0ytFDoD7NPTSbiOfkIpt4W/MYzplyYP31Nz/03m7YrYxFltgchx9qxffBw7mRiuhee
         MOapJtGXB+7QBhUF/tF/2ClyWgWO8QQUHGTTW8aK3WfDD7Cwp2CoV78g7apZo6lwdq
         IjJpys72egLQjs0GHyUkbu1mzNd+pUWrGvg+SAmgi0U0GzSxW7LsK+8Ei7bu1pgll+
         8t+Ne6Dbqou6OlPoCIuZ20DW7vGPm1g/6TqlcwcSH+9D6G7Hlmf0i39uBVr+kCSZwA
         AOemf0b9w83ig==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oJ9cB-0007CL-Qg; Wed, 03 Aug 2022 10:20:27 +0200
Date:   Wed, 3 Aug 2022 10:20:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     =?utf-8?B?6LCtIOawuOaelw==?= <yonglin.tan@outlook.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH] USB: serial:
 option: add Quectel EM060K modem
Message-ID: <Yuovy5ukT9V1ydKS@hovoldconsulting.com>
References: <MEYP282MB23740DC78FB0DE954C59D3DEFD8F9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
 <Yt0FnnVh47y8aMtn@hovoldconsulting.com>
 <MEYP282MB237488A1AB2C7A9B4DA7B880FD989@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MEYP282MB237488A1AB2C7A9B4DA7B880FD989@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 07:32:47AM +0000, 谭 永林 wrote:

> The last interface is used for Qualcomm WWAN module's QDSS(Qualcomm
> Debug Sub-System) port. Users use the QDSS interface to acquire Modem
> subsystem log. It is used to work with DIAG port. Therefore, we don't
> have to bind this interface with any driver.

Thanks for the details (I can add QDSS to the summary of the interface
layout in the commit message when applying).

But are you saying that it's not needed because that data is available
also over the DIAG port? Or is there some libusb driver that should be
used to access the QDSS port?

Johan
