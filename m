Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BB14B16F1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 21:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344224AbiBJU2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 15:28:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344211AbiBJU2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:28:15 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911C4B84;
        Thu, 10 Feb 2022 12:28:15 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id bx31so9752321ljb.0;
        Thu, 10 Feb 2022 12:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vml5uigID9wwvx/PlQfGPRSbZZVlYDUpEbRuwhp0E2s=;
        b=lQxJpuZRKbrjYRk+AyXay/cRjKN560M2OahoDpjCzzb2OGujUrlPndTElEa8/M3seS
         zhgS77DEtiBCseBEetgdEXFMW5dz8FGSsjH3KqwBk4N2RB5L6gsVX4WzWUYoonZ0sf/G
         A1W2cKPLVlroJJ9/3S4cmVoKOg6QT1+werAp9+E4SopOP1iOyP7oq/X7De4OtQXj68RG
         taGCRLCihFoa9nsNfCdFCv9jZ643U8FwlaSCXMTQG410eSS+QfOi1zNzK/Arv7Nkp/LK
         FBDA3SFdvkgGrHSWbrYxayF4AIVehEyQfxFK2cZwBKN8pAWmIWZW6jYy9Du+YFtvlQf6
         3yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vml5uigID9wwvx/PlQfGPRSbZZVlYDUpEbRuwhp0E2s=;
        b=yPBNiRXwA4BbDBNoXJcFchM8TRi0GabzR08r+bDE38qKLHZFNnF73pHFkiA9B1Uu24
         kXOhsrGnYdptP34cD3cW9pU3falcEGlZEbs1G3D4famFySqIO4b/BmZx4nHy+NAjuyWQ
         7OME7yh/k6b+SQTxjXJY80LZHpZmAP3+yuBTIAKCzrF/2ydA/52ehi3NPvW3qcrGoRiQ
         54eCGa4Xo//IwYyrjO4+oA5THy5l+oUe315GGE8fj5qy3OXNx2RXHn9CQdgLVzXKzgwK
         3zxMnkCSgfWG2OqjLLP+aUwC6wsywZkaJIUNqEFNqrhSgX6X4Q3/J9gIQHRUmlCgdaBJ
         k5Aw==
X-Gm-Message-State: AOAM532lWvLgBQa4XsTi1524dSec+VecVstfEM4flzDJWB+OfmT3yiuZ
        VRlkDazcC1dGozP5i0nSf0M=
X-Google-Smtp-Source: ABdhPJxlaU4AbDMA3tdAJCj8pQ7P7mO2f3iSg8/6pS8JrpcHZh+5pVcOdX/Ay+jQV0U47LM1JTZ0tg==
X-Received: by 2002:a2e:b05a:: with SMTP id d26mr6005006ljl.425.1644524893738;
        Thu, 10 Feb 2022 12:28:13 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id d19sm1223881lfg.108.2022.02.10.12.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 12:28:13 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 0/3] drivers/crypto: Constify static attribute_group
Date:   Thu, 10 Feb 2022 21:28:02 +0100
Message-Id: <20220210202805.7750-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series constifies a couple of static attribute_group structs that
are not modified. This allows the compiler to put them in read-only
memory. The patches are independent and can be applied in any order (and
go through different trees if needed).

Rikard Falkeborn (3):
  crypto: omap-aes - Constify static attribute_group
  crypto: omap-sham - Constify static attribute_group
  crypto/nx: Constify static attribute_group structs

 drivers/crypto/nx/nx-common-pseries.c | 4 ++--
 drivers/crypto/omap-aes.c             | 2 +-
 drivers/crypto/omap-sham.c            | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.35.1

