Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B09C509943
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385858AbiDUHim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385859AbiDUHiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:38:24 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24386DEA4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:35:35 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A62691C0014;
        Thu, 21 Apr 2022 07:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650526534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5sUaNXOTPfSNutP1Nw7SXQWnMZHzjp1ss3S3Q/iiVUM=;
        b=DqqHDeRhUgldMcsQYFpqSMHOXjUkSTLj0wpr0kTgrr3W3ou2YcG22IF0xK77bUqWH9paZn
        WG2Sy5RHNhqVKmjvnkVmnyqtYuFShP1GV99cfNy/Uy73y501M8I5+e+Qi3hR8OithBlC7m
        7Oeez/NM8/i22HCoyGgHCyT3xD2gJ3cpYPQgwRkJY+4VCAWs0HCsNoh1HsL5AiLSpztvqE
        u62HdYhqZJRJP1BOSFoPuQHo3SR72pG0KIP7nbixy5ug6HD2rtZfnP/3rzVcg7Th3NQ/du
        LJohDkDLxaKcTIsFfzfK+sDf3VtZtQqByYbmjYjJLQgD9jej5aL9iuYAPWp2QA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Oleksandr Ocheretnyi <oocheret@cisco.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: fix 'part' field data corruption in mtd_info
Date:   Thu, 21 Apr 2022 09:35:33 +0200
Message-Id: <20220421073533.71758-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220417184649.449289-1-oocheret@cisco.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'37c5f9e80e015d0df17d0c377c18523002986851'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-04-17 at 18:46:47 UTC, Oleksandr Ocheretnyi wrote:
> Commit 46b5889cc2c5 ("mtd: implement proper partition handling")
> started using "mtd_get_master_ofs()" in mtd callbacks to determine
> memory offsets by means of 'part' field from mtd_info, what previously
> was smashed accessing 'master' field in the mtd_set_dev_defaults() method.
> That provides wrong offset what causes hardware access errors.
> 
> Just make 'part', 'master' as separate fields, rather than using
> union type to avoid 'part' data corruption when mtd_set_dev_defaults()
> is called.
> 
> Fixes: 46b5889cc2c5 ("mtd: implement proper partition handling")
> Signed-off-by: Oleksandr Ocheretnyi <oocheret@cisco.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
