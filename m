Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CF55231E8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiEKLfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240099AbiEKLfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:35:23 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3B65469C
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:35:21 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BA77E22205;
        Wed, 11 May 2022 13:35:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1652268919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fBxMjfOO74WU/5onEJvdMPUR6WuIE1EbEvkxKemvch8=;
        b=LxIwoQmMbD18/LTL1HymORRMKdrt6BMI6A9PZgP48ewHwtu1+8HzJHelfaxd316z5/Mffk
        8LOQ1lZGALk97YFSIp3XyJhBozStBpUd7ItIpijbqXqgZe9mojO0Q2vtV59UejBeGV6Jbn
        smtdaC7xn6NaAuTKvJR/S6qYEfi7e/k=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 11 May 2022 13:35:16 +0200
From:   Michael Walle <michael@walle.cc>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [mtd:spi-nor/next 16/18] drivers/mtd/spi-nor/debugfs.c:84
 spi_nor_params_show() warn: '%ph' cannot be followed by 'n'
In-Reply-To: <202205110320.WNi7ZQaB-lkp@intel.com>
References: <202205110320.WNi7ZQaB-lkp@intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <f1399a5413d8f151e536c7005eca6763@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-05-11 12:17, schrieb Dan Carpenter:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
> spi-nor/next
> head:   cdbc44dbb2c73d8bafa1a8ae0d780608be5dbd40
> commit: 0257be79fc4a16a3252ce80aa13b3640f728c425 [16/18] mtd: spi-nor:
> expose internal parameters via debugfs
> config: x86_64-randconfig-m001-20220509
> (https://download.01.org/0day-ci/archive/20220511/202205110320.WNi7ZQaB-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/mtd/spi-nor/debugfs.c:84 spi_nor_params_show() warn: '%ph'
> cannot be followed by 'n'
> 
> vim +84 drivers/mtd/spi-nor/debugfs.c
> 
> 0257be79fc4a16 Michael Walle 2022-04-29   73  static int
> spi_nor_params_show(struct seq_file *s, void *data)
> 0257be79fc4a16 Michael Walle 2022-04-29   74  {
> 0257be79fc4a16 Michael Walle 2022-04-29   75  	struct spi_nor *nor = 
> s->private;
> 0257be79fc4a16 Michael Walle 2022-04-29   76  	struct
> spi_nor_flash_parameter *params = nor->params;
> 0257be79fc4a16 Michael Walle 2022-04-29   77  	struct
> spi_nor_erase_map *erase_map = &params->erase_map;
> 0257be79fc4a16 Michael Walle 2022-04-29   78  	struct
> spi_nor_erase_region *region;
> 0257be79fc4a16 Michael Walle 2022-04-29   79  	const struct flash_info
> *info = nor->info;
> 0257be79fc4a16 Michael Walle 2022-04-29   80  	char buf[16], *str;
> 0257be79fc4a16 Michael Walle 2022-04-29   81  	int i;
> 0257be79fc4a16 Michael Walle 2022-04-29   82
> 0257be79fc4a16 Michael Walle 2022-04-29   83  	seq_printf(s,
> "name\t\t%s\n", info->name);
> 0257be79fc4a16 Michael Walle 2022-04-29  @84  	seq_printf(s,
> "id\t\t%*phn\n", info->id_len, info->id);
> 
> Maybe N was intended instead of n?  (I have no idea).

Thanks for reporting. Yeah I had %*phN previously but then
I wanted to switch to "xx xx xx" style and i missed checking
printk-formats.rst. %*phn worked as intended ;) I'll send
a fixup patch.

-michael
