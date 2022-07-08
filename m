Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2022F56BFDE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbiGHQKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiGHQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:10:17 -0400
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5BD74341;
        Fri,  8 Jul 2022 09:10:15 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 5F261C800AE;
        Fri,  8 Jul 2022 18:10:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        tuxedocomputers.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from; s=
        default; t=1657296613; x=1659111014; bh=NCl2xelgn7owsayVRjkRxfgS
        kn+ONd5kNWvw27P20jk=; b=mYSqc2XKdxBP1Wl6YvOCCH8TCtwpCbf6JaiQJ1vc
        gsypwkLVc12u6C81spMUf0LekbtI9B1I59eKS9jf+gKqatV7d0TnU/AHyX+G3q0I
        O73VH/9A5tZfHOPjrmYdC/9cMGmwtQydUuWFt4AvSBeUWbiyASzPLlLsII4BWVOp
        kyw=
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id SsILlMc90GFv; Fri,  8 Jul 2022 18:10:13 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id A081CC800AC;
        Fri,  8 Jul 2022 18:10:12 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     dmitry.torokhov@gmail.com, hdegoede@redhat.com, tiwai@suse.de,
        samuel@cavoj.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Input: i8042 - add additional TUXEDO devices to i8042 quirk tables
Date:   Fri,  8 Jul 2022 18:10:03 +0200
Message-Id: <20220708161005.1251929-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some additional devices needing i8042 quirks for the keyboard to reliably
work after boot and suspend. The first patch are some older devices I found
needing the quirks in our install routine.

The second patch are two devices that I purposly seperated in an own patch,
because it is not clear cut if these should be applied or not:
They need the quirks for the keyboard to not be completly dead by chance
after suspend. However setting the quirk causes the keyboard to lag for the
first few seconds after every boot and sometimes also a little bit after
resume, giving double inputs or missing keystrokes. However this very
quickly goes away again.
Imho the lag issue is less severe then an occasionally completly dead
keyboard. However I'm interested in other opinions. A counter argument is
that the quirks can always be set via boot parameter, but not unset when
they are part of the quirk list.


