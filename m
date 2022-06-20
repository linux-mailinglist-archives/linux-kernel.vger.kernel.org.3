Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6988555135C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240128AbiFTIv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240087AbiFTIvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:51:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE0512D05;
        Mon, 20 Jun 2022 01:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF52A61341;
        Mon, 20 Jun 2022 08:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208DFC341C4;
        Mon, 20 Jun 2022 08:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655715103;
        bh=re/LIYFaBcxg1SjWjXGFFxl9Hd6mgfMNrzdReDBPFsQ=;
        h=From:To:Cc:Subject:Date:From;
        b=nPJkKch4UQztDtvVOyXeFY7RIebmIdoIT9uPlryPezOsuLMMs+gjQIYXSRFblLehj
         /hrBxK+fWfzjS99sHdADkVubsXzqPCNUl3lLuDbGtpda3T0pSAyM51YdJwQa6+Btmr
         uXHhBSS6LmZg1yJgWP0u3uireUMMMon5ucsD1e/oRkIvWMVv4gxwGKTP0SOvWtX7RZ
         9XbQl4TLj+q+39Si1Hm91kdCybOcVag3aoD3dybwybnDH+RyXdbfhvArOWJDt67qcB
         HztQZWX4+ELiDYvBd11WkwKj6GMz5Fw2WsnGKB8l3cHbGq2xM8hC227ctYt8a4HuwL
         YVjs8HfCc+tjg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3D8F-0005Tm-Ho; Mon, 20 Jun 2022 10:51:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] Input: usbtouchscreen - suppress empty array warnings
Date:   Mon, 20 Jun 2022 10:46:26 +0200
Message-Id: <20220620084628.20894-1-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into some new (?) compiler warnings with -rc3 this morning. Not
sure if it's after updating to GCC 11.3.0 a few weeks ago, or due to
some other change.

Either way, making sure that the device info table is non empty is
straight forward and the sentinel value can also be used to protect
against potential future bugs due to the somewhat fragile driver
ifdeffery.

Johan


Johan Hovold (2):
  Input: usbtouchscreen - suppress empty array warnings
  Input: usbtouchscreen - add driver_info sanity check

 drivers/input/touchscreen/usbtouchscreen.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.35.1

