Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60B54994CC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 22:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390380AbiAXUpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 15:45:15 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45828 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381739AbiAXUWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:22:46 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id CA2881F43F0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643055758;
        bh=GSNEWPnRJLYM9HcdPN2TTX4m27DGQnVdB0QfH3N3Syc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DUrWJvmJXDk944dJo8YvSY2F65VFBtgApUNnZkEKR+F/ZnUD+jXt2aNI73eFKEPt4
         bZy/J75hQXpRxQfiCK8xeXMapkeJWPODVicoluPrnfi9joOwgKrfVT+CPd5HaxElDL
         GF8mKXeE4UVQqdU1ZdE3I3r3RGH76wqiQ4WVxph9Y/IXNCITyXgVYIV8+wN/d+ENcb
         f0YG0pDZOCQGEQOPm/2YDRA9u2pXOqXhrEtS22LMFaUuAVtHHnytE2dBuI6bU22XOf
         bz6ldXAbfwrAPLbf4wyeJI+jmDdeOkwxeKz34Xhyq3VWIqbm/Nhj3EUtVIk1GLWVRe
         DYZbnBIvplBsg==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2 8/9] regulator/rpi-panel-attiny: Don't read the LCD power status
Date:   Mon, 24 Jan 2022 15:22:35 -0500
Message-ID: <5533342.DvuYhMxLoT@falcon9>
In-Reply-To: <Yerfr8Nj43TTPcAF@sirena.org.uk>
References: <20220121152056.2044551-1-detlev.casanova@collabora.com> <20220121152056.2044551-9-detlev.casanova@collabora.com> <Yerfr8Nj43TTPcAF@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 21, 2022 11:30:39 A.M. EST Mark Brown wrote:
> On Fri, Jan 21, 2022 at 10:20:55AM -0500, Detlev Casanova wrote:
> > From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > 
> > The I2C to the Atmel is very fussy, and locks up easily on
> > Pi0-3 particularly on reads.
> > 
> > The LCD power status is controlled solely by this driver, so
> > rather than reading it back from the Atmel, use the cached
> > status last set.
> 
> If that's the case since you're using regmap would it not make sense to
> enable caching in order to minimise reads in general.

Would caching avoid all reads if the values are written at least once before? 
The idea here is to make sure they are never read, I'm not sure if the regmap 
cache ensures no read in this situation.



