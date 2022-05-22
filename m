Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099AA5305AC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 21:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351061AbiEVTvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 15:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351232AbiEVTvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 15:51:12 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5FA3A5C7;
        Sun, 22 May 2022 12:50:46 -0700 (PDT)
Date:   Sun, 22 May 2022 19:50:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1653249044; x=1653508244;
        bh=ezBQ8JYOZeSPzQRYI8sNEvLFSFA0gqUVqyugk66GrR4=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:
         Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=WiD+IzqNyXBeHy+D0ktqFqdtWupjHckyK2nsD6QgH9UpajKFW8PQNqxsb4wNFxX/g
         M2tzLSwU5hvCe3plF78c8nBT+o1BDRnIY/syObHxZtUa1t0TzQxBmmljy5CQ5uNDIs
         IP6ieDH9zRVGUys1/jbKK4mZgCz6LtMNxfRXyTAVv2S5Vv4fBJc52x6jEFbCUdczqw
         /YIuOQAk8v7YJa8RW+6wYFks3I+Qz+UBc9OZ4zl3Rw4uxXQXY73XTvEK7EYYxkOhQF
         mVQ5W02SWJBPWn67/BcwPn6E1cQv8fzBVykudLpDv/plVMpquLQjxcxfMQLV18kVEg
         eHhMgJmj5IGGA==
To:     Jonathan Corbet <corbet@lwn.net>
From:   Nelson Penn <nelsonapenn@protonmail.com>
Cc:     linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nelson Penn <nelsonapenn@protonmail.com>
Reply-To: Nelson Penn <nelsonapenn@protonmail.com>
Subject: [PATCH] documentation: Format button_dev as a pointer.
Message-ID: <20220522194953.12097-1-nelsonapenn@protonmail.com>
Feedback-ID: 19766786:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The docs on creating an input device driver have an example in which
button_dev is a pointer to an input_dev struct. However, in two code
snippets below, button_dev is used as if it is not a pointer. Make these
occurrences of button_dev reflect that it is a pointer.

Signed-off-by: Nelson Penn <nelsonapenn@protonmail.com>
---
 Documentation/input/input-programming.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/input/input-programming.rst b/Documentation/inpu=
t/input-programming.rst
index 2638dce69764..c9264814c7aa 100644
--- a/Documentation/input/input-programming.rst
+++ b/Documentation/input/input-programming.rst
@@ -85,15 +85,15 @@ accepted by this input device. Our example device can o=
nly generate EV_KEY
 type events, and from those only BTN_0 event code. Thus we only set these
 two bits. We could have used::

-=09set_bit(EV_KEY, button_dev.evbit);
-=09set_bit(BTN_0, button_dev.keybit);
+=09set_bit(EV_KEY, button_dev->evbit);
+=09set_bit(BTN_0, button_dev->keybit);

 as well, but with more than single bits the first approach tends to be
 shorter.

 Then the example driver registers the input device structure by calling::

-=09input_register_device(&button_dev);
+=09input_register_device(button_dev);

 This adds the button_dev structure to linked lists of the input driver and
 calls device handler modules _connect functions to tell them a new input
--
2.25.1


