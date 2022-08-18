Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC75A598700
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344214AbiHRPKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344173AbiHRPKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:10:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17940BD742;
        Thu, 18 Aug 2022 08:10:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a4so2096583wrq.1;
        Thu, 18 Aug 2022 08:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=HDI1guW7fTa+RVY8P7QOf7gM0cs1vrvzc2yBNv9u5SE=;
        b=pi18Uu3bBrZTRbAXiS6PuQjqgRje84joS1DXu7tygGEijyzcK9P+MFJZcya/f8R+ZN
         /r3sAu7PcgwrG8tjJABO5xNZd32kSvx+hrg4SNO5XKW7rhc+ZKrgDeeuhKCq25nHaRuX
         fQRJGdnjnKXf5wvjzF+sQtXu0GLKBnpQdE6/c+H4CMLkqZgB0N8QTJxfHBruKMhm1tr8
         hjpxtzDdiVNQxjjGEO3L5yhAQaR+DLNahI9yvN589uvWkW4o87iuepUGrPNnqyDtAHio
         m/R5qvSWifN/WGVBGnwUFDU+I9dOedFeW5FujqJgkrngnYJir7Ey3UBIB0Zp+qPjei6C
         Q9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=HDI1guW7fTa+RVY8P7QOf7gM0cs1vrvzc2yBNv9u5SE=;
        b=Ub1GeEYOV/ciO/MijcfL0JWLWetVzFpJwvvvtb8gXv478F7FnNSvZ9TMf+p1PJinzp
         5bWLX76Y91IqouyvisX8ID+XVib59iPJ4cAAVv7i1LmEvi8HUrOT/wqCiUipU1dQ30Tj
         cObeAsJPcejtEv571FLKrXyzj7OtI1yRwJo4LaZhH2bEJ5ItI67Zmq3IXKt7JRfnzylc
         3xWSxcSQx76FU3A5L1P283+SyGhSl7VI+3OdwF4hiBsFrklPKFpYJW2LPWSTkbFssd7U
         vAKQjX4M/kSf2ovA/NVv53yWZVYI2Otv5GLA1TWkcgmO2Cbf5tzb7Yj/Ljaf+UV5Gh10
         jSsQ==
X-Gm-Message-State: ACgBeo01mtl3Szgv68KZy0Q5/24gxszeZ4fvMOMNhiS/U8rE7V3Y5Ir2
        mI3ftSZLaNQMP0bnSKt4qnw=
X-Google-Smtp-Source: AA6agR5sKQZY1jZx3FWEs8Qil3XXRCsi5pQaditAs9pKXE5Vd5G0X3PIU8DmysByDd5tYjAjOC3RvQ==
X-Received: by 2002:a5d:4907:0:b0:21f:bc42:989 with SMTP id x7-20020a5d4907000000b0021fbc420989mr1894232wrq.375.1660835442418;
        Thu, 18 Aug 2022 08:10:42 -0700 (PDT)
Received: from hoboy.vegasvil.org ([185.228.40.98])
        by smtp.gmail.com with ESMTPSA id q1-20020a056000136100b0021d80f53324sm1763997wrz.7.2022.08.18.08.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:10:41 -0700 (PDT)
Date:   Thu, 18 Aug 2022 08:10:39 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Shannon Nelson <snelson@pensando.io>,
        Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Joel Stanley <joel@jms.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        William Zhang <william.zhang@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 06/11] ARM: defconfig: drop CONFIG_PTP_1588_CLOCK=y
Message-ID: <Yv5Wb/nbOW2vJH5Y@hoboy.vegasvil.org>
References: <20220818135522.3143514-1-arnd@kernel.org>
 <20220818135737.3143895-1-arnd@kernel.org>
 <20220818135737.3143895-5-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818135737.3143895-5-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 03:57:15PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> PTP support is now enabled by default for configurations with
> ethernet support, so drop the redundant entries in defconfig
> files.
> 
> Fixes: e5f31552674e ("ethernet: fix PTP_1588_CLOCK dependencies")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Richard Cochran <richardcochran@gmail.com>
