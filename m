Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA09C5A46AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiH2KAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiH2KAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:00:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967DDDFDB;
        Mon, 29 Aug 2022 03:00:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id az27so9486417wrb.6;
        Mon, 29 Aug 2022 03:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=l0dd8ecbpZnuzsCu5JGEpd3FIwlZH2NjRr90vsXjRJU=;
        b=Vxenx/x3aciurxig2M6JStt1bFKy9byWFgerDbAaMMmGHP5hv1Zv4mhoRvPo+RU0rj
         3xUO7ahTZi2vegvvvjlSv+HbTYM4nUGlWqK1jJD/n00UYVtxad9hsM3DtjjLw+gV8HII
         2c1EFG3PGwSwVukbr1Ma3AGbzLEh+dAhUN6XeLsfBhp7ce/2WFobApiKPQsXw12wBh7e
         2vaHtkJYxTMzCIvoK4I9rwI6A+2hGzMpYu3mv6UC28SvgrhGOIcnr4EU3Aelhl6yoEXK
         jwfMbaYzS54AfqgtbevJedt76ZY24iaACODyX/I0ysJIUBzqf0ws+wRJL1xp4MDHMwjp
         DcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=l0dd8ecbpZnuzsCu5JGEpd3FIwlZH2NjRr90vsXjRJU=;
        b=IGK1QKwPK4bH4/QiUU27iwyA956SfJ3wqcB0DKT3HTW0lg6OjQrgqXf95MSqy9/dkT
         ELthYP30l1PMbMiqzYlOfKiw8U8dUFwSmBNeMVGI7HkQ69dndArHOiGWsd8Ny/MCkWlz
         v2ffTkay8z+CE+Q9tylCPFkvZHhLwjfTjhsvg2tBF13FS8O8sTa9JrsAclhKAaW819BJ
         +TwYX+VtRDtWuXZCkwq+yZ6dFnWHqfSdd5HZATVTkKYH/TH+2p8veRoO/ZUs+W7FLlWi
         b6Lk6diNpZK1MIjSo7+dcHMYAOe67lf/wRX2v+T69azYZx3MbliS61zWNvR3lk0hpehZ
         w1+Q==
X-Gm-Message-State: ACgBeo0cHQYRv4WyO8U6KPbNwlOyJh5SBWeCWEna1Cwq2HAAqpsUtmwT
        UcNWaBDYeLAp4InuXiNJPtGNkVBDOVE=
X-Google-Smtp-Source: AA6agR7p1BSAyfx0TInY5Ker3Q46WxaH2F9v+jEvrWs9zSmBL9VOugQdt15Cdyt5riIsyGP3mdmBrA==
X-Received: by 2002:a5d:4082:0:b0:226:d019:c91e with SMTP id o2-20020a5d4082000000b00226d019c91emr5941444wrp.557.1661767241168;
        Mon, 29 Aug 2022 03:00:41 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id c21-20020a7bc015000000b003a5c999cd1asm8881424wmb.14.2022.08.29.03.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 03:00:40 -0700 (PDT)
Date:   Mon, 29 Aug 2022 11:00:38 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Johnny Huang <johnny_huang@aspeedtech.com>,
        Dhananjay Phadke <dphadke@linux.microsoft.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: build failure of next-20220829 due to 108713a713c7 ("crypto: aspeed
 - Add HACE hash driver")
Message-ID: <YwyORp72cuDrVYdA@debian>
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

The builds of arm allmodconfig have failed to build next-20220829 with
the error:

ERROR: modpost: "aspeed_register_hace_hash_algs" [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
ERROR: modpost: "aspeed_unregister_hace_crypto_algs" [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
ERROR: modpost: "aspeed_register_hace_crypto_algs" [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
ERROR: modpost: "aspeed_unregister_hace_hash_algs" [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!


git bisect pointed to 108713a713c7 ("crypto: aspeed - Add HACE hash driver")

I will be happy to test any patch or provide any extra log if needed.


--
Regards
Sudip
