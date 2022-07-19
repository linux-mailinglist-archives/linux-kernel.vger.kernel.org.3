Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1B957A201
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbiGSOlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239521AbiGSOkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:40:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C10F77;
        Tue, 19 Jul 2022 07:36:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z12so21912214wrq.7;
        Tue, 19 Jul 2022 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=+my388e5tPnWcJpGm6Gte0J2XmbtF7HUvaYs2w8CeFg=;
        b=cKaVd9RppTLMlbd0s1GsZXbV1EhR75l9lVjUmohRvEc8oEAhbZJip9LcJMTJKk5LaG
         TMBTna2MOBiFg4Oy+BvEAfgmXZ3rGTjJYTwenyzoA29bu7dOW44BRScqxEzktDynVjud
         DQN0N9i70wT2VYFG0eEbbNZqxWOlW/sMyKzmpTTUDCbNiu3jxQtsZq+0og5IJ7fJDeIG
         kGKndH1pGdJyKgR+1+aE4o3S7gtQmhxkUUb9LSuTn0ELrpGmRuQvqJ1vD/njx5uiJtj2
         JYYnoZksjSN7CXNPD02IxG4bb0/MtCHedS62C2m4Oi8t99TA/rU43ukag0x7ypxObE9R
         KviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+my388e5tPnWcJpGm6Gte0J2XmbtF7HUvaYs2w8CeFg=;
        b=WfJnAVHcILJsIzlqcBsKfJCBJ2Q7vCoosttS6fduVzEzwJx82ryAuVw/Fxr7xP8aV/
         OlkuUC/vw1s0GdzpPeD0yvQCdYYPKFQqEYHWQFaJVmAe0rK7UVNM/OAyTP+/GWENvBzA
         6WJIr7DCJERXl2tQyehw1QINbWXkfl2MqBKHlsUHMjuX2gOgPhYHJ5b7dFtU6LJSiK9l
         RGEv9OcMLBr8LxQh4ZV1WPz8w7PO/3H+EBUHTOQZWXJE1y9bhpfx7MhIta/AERxq6Kd4
         82gnBXVWiXNu7dZ4a5uTJFYhsCHhUJ+1gA58FW9nF6LFHWlS9U6Ed6vnwVztFzSBDvqA
         wsrQ==
X-Gm-Message-State: AJIora9rwiF8jNGPGijHWxLojFc98qdui5ow0roStWhN/jQJUcJZV2j/
        xzBMmdbQMrt+p3KJFr1my8g=
X-Google-Smtp-Source: AGRyM1unVBO5JXk+ZwBRLtEzVYrlfSnpQoY6dSsXzaaJsB7F06eubwEBLfjjLCpNP289vy//wvgL1A==
X-Received: by 2002:a5d:6481:0:b0:21d:9c1b:ad8a with SMTP id o1-20020a5d6481000000b0021d9c1bad8amr27362490wri.67.1658241393863;
        Tue, 19 Jul 2022 07:36:33 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id s6-20020adfecc6000000b0021d74906683sm13951078wro.28.2022.07.19.07.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 07:36:33 -0700 (PDT)
Date:   Tue, 19 Jul 2022 15:36:31 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: build failure of next-20220719 due to 'missing MODULE_LICENSE() in
 lib/crypto/libsha1.o'
Message-ID: <YtbBb3gCsKfpsaXP@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Not sure if it has been reported, builds of arm milbeaut_m10v_defconfig
have failed to build next-20220719 with the error:

ERROR: modpost: missing MODULE_LICENSE() in lib/crypto/libsha1.o

caused by ec8f7f4821d5 ("crypto: lib - make the sha1 library optional").


--
Regards
Sudip
