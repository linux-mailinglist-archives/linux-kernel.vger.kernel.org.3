Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09D5583FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiG1NcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiG1NcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:32:07 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCC045040;
        Thu, 28 Jul 2022 06:32:07 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c3so1918309pfb.13;
        Thu, 28 Jul 2022 06:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1MQM/vL3QNNnRpEU6OSTQU5od8eHLRMAbnHqrveeBzc=;
        b=LDXtjSsO5y+3XlkpTdytIB+0iFlhU2pnoZ5PgHpNo8lniWCAX/ETlCgn2f/1vMKFPT
         AFva0N6R5wqMePnu2iaIWeM5769l/gj52jCB/8q3xIaxWCnRCnptL9CQGMzA5q+r4Juk
         XORgboOQUMfOtWT41L+3vLnceLgKIT9mkFO11f/nC+KOJ/xYwCMmtV4sAP2HdRYIeeKm
         F3DLWjsx4kuLG1dUfdLG4GnhnBl9pND6iMfXPi7RT8AY51YizObounXVQDSXn7RDxDzL
         yvqBlrHAUEqQufp5OGYkizZIs+5QmeYWu100yErm1ua4199Crzcd9MW3+Ome1iXbT116
         wXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1MQM/vL3QNNnRpEU6OSTQU5od8eHLRMAbnHqrveeBzc=;
        b=aCvpGFZAwNVNQ0ygea/zxAYJtZtjgKA/COqvL2nJ2Cnf0cIDXjjq7y2HHZavQM5SFQ
         57UzEuI320dUl8UlwGnr9heQmFZMGeQ79HeBGiHfwUIHdyN4044xFRc1qp5+2L1gT2lY
         6J3JLJoEoDnLm3oLKRktbAJnfEcVB5kt29n6wXnGOUwb9OJRDQHtDmfeu2gcG6sK9Vlt
         qnhw+6UNhRi85l3uossIB0+J50OkIt9jVCnAjHWvM1KGw578PZc9I7rxsPnOPgbUz51A
         36om/4/F35S5p6sleesQ1iILv9dSX2sWGN/uhxPMiDkoXBFzcSKxR1kvQUz7HlHnXeoM
         lX2Q==
X-Gm-Message-State: AJIora+5cteQAycuwPheJKZkv/FdEVUdA59QBuehk2IObWKLODPnlAPx
        d4aiOyPMTKdXBJpG6A6cNsHlfpZlz5JAaw==
X-Google-Smtp-Source: AGRyM1uxM5zACYMiOC0mk+eJyjekRabvgtsXaPA0VX/lWAst3HVU6fWfE76JZwt0wyi9TWPNyKRxnQ==
X-Received: by 2002:a65:4cc7:0:b0:41a:4df2:4839 with SMTP id n7-20020a654cc7000000b0041a4df24839mr23948737pgt.37.1659015126614;
        Thu, 28 Jul 2022 06:32:06 -0700 (PDT)
Received: from localhost.localdomain (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id u188-20020a6379c5000000b00419b128cf98sm928474pgc.54.2022.07.28.06.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 06:32:05 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v5 0/2] iio: humidity: hdc100x: add manufacturer and device ID check
Date:   Thu, 28 Jul 2022 12:54:33 +0000
Message-Id: <20220728125435.3336618-1-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this patch series, we move the callback from probe to probe_new, and add
manufacturer and device ID check for hdc100x driver.

LINK: [v1] https://lore.kernel.org/all/20220722172035.44977-1-potin.lai.pt@gmail.com/
LINK: [v2] https://lore.kernel.org/all/20220727064415.940690-1-potin.lai.pt@gmail.com/
LINK: [v3] https://lore.kernel.org/all/20220727164133.973930-1-potin.lai.pt@gmail.com/
LINK: [v4] https://lore.kernel.org/all/20220728003417.3083353-1-potin.lai.pt@gmail.com/

changes v1 --> v2:
- fix typo in commit message
- change to use probe_new
- use device_get_match_data instead of i2c_of_match_device

changes v2 --> v3:
- move probe_new part into a separate patch
- remove unsed variable
- remove redundant checking of matched data

changes v3 --> v4:
- move ID support checking to probe()
- add hdc100x_chip_data pointer into hdc100x_data for accessing in future

changes v4 --> v5:
- remove hdc100x_chip_data pointer from hdc100x_data structure

Potin Lai (2):
  iio: humidity: hdc100x: switch to probe_new callback
  iio: humidity: hdc100x: add manufacturer and device ID check

 drivers/iio/humidity/hdc100x.c | 72 +++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 14 deletions(-)

-- 
2.31.1

