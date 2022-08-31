Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452B25A7AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiHaJyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiHaJyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:54:39 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1734D0207;
        Wed, 31 Aug 2022 02:54:38 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id az27so17524573wrb.6;
        Wed, 31 Aug 2022 02:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=AjyGAORD6u0Zr3At+X7QhVbrZQwkooLQ7kUsqjrz0sg=;
        b=m5dVv7DImPdipFQPZb6beQLx3/OErYk+jQ0h9IHZYMhtlLyjpfUN4RuJrq+mF7kbWI
         YzrZ7e40hdsZTUT1kEWL5Ly/Be0t/j4qJTsyYtI23VZ9eOPZombfj/S7X5+N+Jhxq1OX
         pc/SJQLfzbygJlMjiXw7l5zyColRVT4nVMQ87J2uPgNZRPE1W0DaCT7BfpWrU53kbrCo
         R/R2pAyRuEDNcvtO204pB28tzlCS1b8eBMZ8D9zEfx9fegs2AFVH5Gb8Opmctqs2H+de
         iFyWbClnVazOfMsCI9gUAbugBH2JzdcB/XhoMvhfbwvEpL8sjAwrv861JaCN+aDz8F/B
         87wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AjyGAORD6u0Zr3At+X7QhVbrZQwkooLQ7kUsqjrz0sg=;
        b=vKDcy2zKltDSde47PAyHJUHytUj9OrlCGqR3Yh2E1Ge+gWCq30wMaU4Fs3WaxFxEgi
         dIFNFMn9MnqVcgAHIFuDfHB1ZwOu1rho0Yq8mi8wcTjr7kJ1t17O8FwEnb4L6CSU8TOc
         xU98DIACNXV8vpiP2h1Y9XKzVBrOt2yuPvFlxtlUqbdPmXoWjoW6DUxZ1Wtjak1lXDXP
         MMYOjeiyr/HCfZsvTqONi2/5H/fXmPq/5XKwFiCBjzJhtKTeWKVXMdVysanTK+B//D/2
         Jvk4xAWjLLyssS4YjoRAOhH3EZcy8CylJxdP3kjrZA1u/8VyBL/cS5pYEe3OqPTYklbh
         BdJQ==
X-Gm-Message-State: ACgBeo1j/j25CuKkP9GNpO7k2FtXnU/asKB9MN1DVyGkbEiTwKhyLxc7
        ZjB7CI5fUGfyHA0BAxBgRgpRirgzd7Y=
X-Google-Smtp-Source: AA6agR7igv2/Dwwn7uBfi3MFcxGoT++4TUW+wI/H+iDLCCI8a9jEkGiuv2ZAksN0HlepSsvTty8sDQ==
X-Received: by 2002:a05:6000:1888:b0:222:c96d:862f with SMTP id a8-20020a056000188800b00222c96d862fmr10905639wri.706.1661939677264;
        Wed, 31 Aug 2022 02:54:37 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id k1-20020adfe8c1000000b0021badf3cb26sm14140853wrn.63.2022.08.31.02.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 02:54:36 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:54:34 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: build failure of next-20220831 due to b35b2736b43d ("ARM: 9230/1:
 Support initrd with address in boot alias region")
Message-ID: <Yw8v2u4TM0m0l5u7@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Lots of arm builds like zeus_defconfig, viper_defconfig, mv78xx0_defconfig
have failed to build next-20220831 with the error:


arm-linux-gnueabi-ld: arch/arm/mm/init.o: in function `arm_memblock_init':
init.c:(.init.text+0x1bc): undefined reference to `phys_initrd_start'


git bisect pointed to b35b2736b43d ("ARM: 9230/1: Support initrd with address in boot alias region")

I will be happy to test any patch or provide any extra log if needed.


-- 
Regards
Sudip
