Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4302E58F0D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiHJQ5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiHJQ5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:57:05 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2092983B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:57:02 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id AEC06240028
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 18:57:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1660150620; bh=1O+saA+RO333tBIlQHbodRBUTU7Qknox3og0fEHKBoI=;
        h=Date:From:To:Cc:Subject:From;
        b=g6TI6O+IIAg2wi/xnH3jZx60SadPTyFM3Jejgd25EMs2VH+oJ2vDsElIHiZV2OQAy
         eA8GGl6i3QLmGmALVM1QJeB5f/s4OCFvC/Hqjg0FbC1pKoTIRff3j9ImPTEkgEL8hG
         6ADkv96agRWals9drjs5PHNvNbahwdA0pcwkCMP7NTXccgGAgoWkuOFjFt1cHRWmw8
         jEPUeO+4dycklw05KxF7ashncD7WVq9sgjnC0olQ9y14no5zqtB4ctp6GuPTQKUE8Y
         tsUkjsPd2cAmo5mSqddI/bwj9f0Uudn2H3SX5TK4sLyCU/00GX/gaQpZtOB6HKQtPM
         k2po3c97KmG1w==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4M2x1R42Hhz6tnx;
        Wed, 10 Aug 2022 18:56:59 +0200 (CEST)
Date:   Wed, 10 Aug 2022 16:56:58 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: corsair-psu: add reporting of rail mode via
 debugfs
Message-ID: <20220810185658.6e27d9bd@posteo.net>
In-Reply-To: <ace70782-777f-ab7c-d190-735f5c65a5e4@roeck-us.net>
References: <YvO4cfx12Q9gcmPg@monster.localdomain>
        <ace70782-777f-ab7c-d190-735f5c65a5e4@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2022 09:31:21 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 8/10/22 06:53, Wilken Gottwalt wrote:
> > Add reporting if the PSU is running in single or multi rail mode via
> > ocpmode debugfs entry. Also update the documentation accordingly.
> > 
> > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > ---
> > Changes in v2:
> >    - fixed spelling issues in commit message
> 
> You did not address or even provide feedback on my second comment.

Oh darn ... sorry, I was quite busy and didn't really pay attention. I will
answer the earlier mail and think about it.

Though, maybe you can help me with that what keeps me so busy. Would it be okay
to use a kthread in a hwmon driver to do sampling (500ms - 10s) in conjunction
with HWMON_C_UPDATE_INTERVAL, or is this a strict no-no? I know it is actually
used to set a sample/update rate in a sensor (-register), but this USB-HID
approach is a pure polling thing. It seems to work quite and enables the driver
to collect data quite early in the boot process.

greetings
