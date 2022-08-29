Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532225A4788
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiH2KuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiH2KuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:50:10 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A42EE14;
        Mon, 29 Aug 2022 03:50:07 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-334dc616f86so184851077b3.8;
        Mon, 29 Aug 2022 03:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=02up1+XGpVBi6AHgu/b3rfxqhl6KNaHX2V6z5XwpNUQ=;
        b=FZYEAwYrJTXa7MsPzOQh2xbVZi1FbFX9IcQNMRkqQdm9zbUnGHL/idtZB+Wq+Bd7qY
         k69FxQOyMPx8RL8rzQWnnrF67yiSpujwo6HL8Lq3ow7Gqb25hbVHnSWpUyjuqWTFAWIB
         MD3IpffnxVIyhMOTKTO4wEOPkxSkVoZOu9QH60SBKzeXDeP6kwq+7NsIIPr48LMNETz7
         YQMJmaUevpD+WacOBXcQav55ukD+LslXoHuhR/FTZ1WQEH7w8XLdYGyJGWryktR6Ex2W
         biPYNa2pdTXWI4J00/thRIi6wN2As4wpQvkK1qjPq6bcK1wqBsJ+47BFACy0KCnIMf4m
         DMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=02up1+XGpVBi6AHgu/b3rfxqhl6KNaHX2V6z5XwpNUQ=;
        b=NBWU5juqpDaKwigKzdJsy/wdlkB42tbN+zivpp0nwS6yMu4KdZM5BEg0yuqCIrZvBo
         Niti1pGLjC+KW13S9XTkJi12MRQodCFQdw5TZcYRM5tH0SsLNquilXSh3vMY7LdYhbWH
         cOGVDHcyXt8EBvDQRGZq9Jxcl15zHF7zfH0YIBp7CKV+wjwsfMQIDlMxfMxTfkmUnOze
         yn17oxp7nfVTZZrUOZ2y/qM8oTFCUEAHwIP4J8ve2rqPiOUvjYf1HWr7cvbt8ZOZ6TVB
         Eal1yvGznhUQ/lzeBc2yY0t8FXznyQsauwj5TUNZsr9d54jMlb+x9QuopsRuInYGPkBM
         HIMg==
X-Gm-Message-State: ACgBeo0F08/B0rs4aMAkg4Pf/mpW+WY365pL9i90Gle5o8X+5vUfUWOd
        byDq05JVC/wAhDDGjnreI51Vhdeo2F1NiYv8JUk=
X-Google-Smtp-Source: AA6agR6SKcxVKiwCDQPt+dP0L06eeP9L3P+uYhWmB35aaik/7nramB2p2rbW7TraVVfQlPcOhSTNk8A4YTSjFJy/9OI=
X-Received: by 2002:a25:40c6:0:b0:67a:5c8a:21d2 with SMTP id
 n189-20020a2540c6000000b0067a5c8a21d2mr8144310yba.158.1661770206527; Mon, 29
 Aug 2022 03:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220829072035.1539399-1-neal_liu@aspeedtech.com>
In-Reply-To: <20220829072035.1539399-1-neal_liu@aspeedtech.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 29 Aug 2022 11:49:30 +0100
Message-ID: <CADVatmNzj2XAPL5bA5JKW9gbMM7bUoOOqh=9+Fh4v79Z-=BjgQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: aspeed: fix build module error
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        BMC-SW@aspeedtech.com, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 8:42 AM Neal Liu <neal_liu@aspeedtech.com> wrote:
>
> If CONFIG_MODULES=y and CONFIG_CRYPTO_DEV_ASPEED=m,
> build modpost would be failed.
>
> Error messages:
>   ERROR: modpost: "aspeed_register_hace_hash_algs"
>   [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
>   ERROR: modpost: "aspeed_unregister_hace_hash_algs"
>   [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
>
> Change build sequence to fix this.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

-- 
Regards
Sudip
