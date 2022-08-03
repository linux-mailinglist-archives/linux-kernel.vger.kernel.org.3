Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145DD588951
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbiHCJXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHCJXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:23:45 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB7919C09;
        Wed,  3 Aug 2022 02:23:44 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id A9E2141242;
        Wed,  3 Aug 2022 09:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:message-id:subject:subject:from:from:date:date
        :received:received:received:received; s=mta-01; t=1659518621; x=
        1661333022; bh=dmK9vb916vEJit/OWSlYMYSc9OyvaPfGlvzUpn8CPy0=; b=H
        +mZPSiOYVV8T9u0b8koKSuwRNCM1G0WnnH5fwmEM82Ht4Lx2v0utndBFK4N4bdJc
        7gttPR5Xo30OtmpxNxw2oGAQTtZG1xCuSpitfvKONLsop0/0I77qkyvg2A6A/0kG
        YSFDGtLguXzM7M9HKHJapXIP5+WE9ad+slDstYliAc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WeuR4BRE3RPB; Wed,  3 Aug 2022 12:23:41 +0300 (MSK)
Received: from T-EXCH-01.corp.yadro.com (t-exch-01.corp.yadro.com [172.17.10.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 9A12E4014D;
        Wed,  3 Aug 2022 12:23:39 +0300 (MSK)
Received: from T-EXCH-09.corp.yadro.com (172.17.11.59) by
 T-EXCH-01.corp.yadro.com (172.17.10.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 3 Aug 2022 12:23:39 +0300
Received: from yadro.com (10.178.118.226) by T-EXCH-09.corp.yadro.com
 (172.17.11.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Wed, 3 Aug 2022
 12:23:38 +0300
Date:   Wed, 3 Aug 2022 12:23:37 +0300
From:   Konstantin Shelekhin <k.shelekhin@yadro.com>
To:     <wei.liu@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <ojeda@kernel.org>,
        <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v8 28/31] samples: add Rust examples
Message-ID: <Yuo+mWyF8hgOdfCs@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220802200430.qiyy2utts4lai3ac@liuwe-devbox-debian-v2>
X-Originating-IP: [10.178.118.226]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Their types are different. One is for u8. The other is for UTF-8.

Yes, but:

  +#[derive(Debug, Default)]
  +struct ModuleInfo {
  +    type_: String,
  +    license: String,
  +    name: String,
  +    author: Option<String>,
  +    description: Option<String>,
  +    alias: Option<String>,
  +    params: Option<Group>,
  +}

  [...]

  +impl ModuleInfo {
  +    fn parse(it: &mut token_stream::IntoIter) -> Self {
  +            match key.as_str() {
  +                "type" => info.type_ = expect_ident(it),
  +                "name" => info.name = expect_byte_string(it),
  +                "author" => info.author = Some(expect_byte_string(it)),
  +                "description" => info.description = Some(expect_byte_string(it)),
  +                "license" => info.license = expect_byte_string(it),
  +                "alias" => info.alias = Some(expect_byte_string(it)),
  +                "alias_rtnl_link" => {
  +                    info.alias = Some(format!("rtnl-link-{}", expect_byte_string(it)))
  +                }
  +                "params" => info.params = Some(expect_group(it)),
  +                _ => panic!(
  +                    "Unknown key \"{}\". Valid keys are: {:?}.",
  +                    key, EXPECTED_KEYS
  +                ),
  +            }

In the the end all module parameters are String, so why not use &str in
the API?
