Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2314A510971
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354388AbiDZUHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242279AbiDZUG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:06:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BA8CFB8E;
        Tue, 26 Apr 2022 13:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651003410;
        bh=GYjS/gv0IHJ8rSFr5iam6Q9tJCHkTMNvcWZmu5izDow=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=GELv81uJWvr4O/Sf/gnnhpEtKt9w4xLHxcZoP4AriP2EZTWR48tjvvxbl7xfbJicY
         j68L96tpLkIobJYuPBxj1v4pR4M37f1JqgZMel3ADuKSUfLWiDX1FTyhXpZIPgw8MZ
         X6HTMojXXjvTIZGw4z+kYu4PDSBouN0dThr+UIl8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MtfJd-1o0qnl02md-00v53Y; Tue, 26 Apr 2022 22:03:30 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] hwmon: (dell-smm) Improve init code
Date:   Tue, 26 Apr 2022 22:03:17 +0200
Message-Id: <20220426200320.399435-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aBQsTk+1fzm5DD+3vQNzawaqLa5BRkW+lG4RmLBD0jhd4VhcYDS
 qRI+XySz2aimYRSyM4eKVIzXwWVnk8FMTGb9aMmExe7mZV8VljULvyxpICMs6rw4IRMgR/f
 T0Q7iQZrIgUMUBw3klAxgvO2hiVFX6ddssDuVNBgvjK85G8+M4iKbeEngumpGshNAe5xGcJ
 NLvyICWHJvAbOaa3ciJnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fXYk06vVGyM=:QPTcWPxLiXM0wu2xLMSMIs
 cqyKgh5LlCdNb6y34I1JAi+RlZ8hHFP71ePlpCGt4fcOlNMO4Ogi3jGV1+A8RXai9td0G/Phy
 GmW/3ia0sw5zMJnfQ6K5WtWhheoyVoKcbvAWzMW9jqpnxWUL2FHkMn+6xiJEM8GC188WrlHSx
 uZ0IffVdIxF90/6DPKRxp5u6E/4MRwMAyZcotu+oViLseWnnRgrlIxlQ3aBn1N/dcxFP8u9Pz
 DCPTT5jpZcIzSDkZlTI1PMiQWyUlZgAx7CZhROjPG4NzBrtdPCSy08tg60jWJUu/SaMwEW5HR
 XeQqsmASoI0wxrSWWU2E0XNgjwile+sCmSX4pNl8pvPpqnlxJt7RrWw5HfIs5Bhxkk1aQWjqH
 3UWVh289L+VgdOA6OJHk0TnrwhWgk7UUMxK3NLJfk+VATXpLpqMNk5ktCosp/mh7ppIfo8O/u
 lU7Y9oyvPZvctMC+9WrF+i9f6+CmRkG1GV2O6b/sZedCWZdjXlSMm4z4ICDFXFvcPpCXnFxNq
 K5S5Ezk6gke1njLIWCOmGo9YycEhr6CLhdV7e7e42sB+rbupcnMqJs+QJoVIn2e7phbB2LQBl
 Mf/GFThbiaEugq5Nmkjuy4eSpWpAIo7E43rjgXeCh8t8nbOOeZQsVRlKhhrESHQJsDL9kA6XZ
 nYiAnpyTYtc+nIpBXhin7rI6nXO+mzPO8OTJmXU056ZVAK1U2fhBhj/jgH72TPuHCPM9e1S3m
 +rwgMPu4UHg+NcD9fmSxqzTOtguULgqfgWYID0vF9Yl97BXiOR/jwuM77pDELzRZ0hlJq3CrS
 KMH8wY+ikvIwbrolHHtZdBGTWlZp17hrdZ2QeFp3b1rNRjAgk+TxEIksteXGakXaE1BnMuEYf
 NVwXje1UpA8qPgsGgROkQiVzafVF9ab6ywJKtz6sc19ju5pbYzfs7uWtjop3ORdS6CfrvTt/j
 XyrwLJwmtoq1GEY30aj3MArZVa7jWqV2jSx/d0sTQr8IHwp8KMTnKO3hXh/SViy44P/B1Huqk
 pUCcTttK7GcdpNR0H+Xce295YgtsiiF7ndCnHWRPC3XfsfN2lahcL35OaHJkBw11pPN6PRpqN
 1DW6rTsSjte8+Y=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series improves the init code of the dell_smm_hwmon
driver. The first patch speeds up device initialisation by avoiding
unnecessary SMM calls during init, which might be slow on some
machines. The second patch is a small cleanup patch, while the
third patch allows for easier diagnosis of audio problems caused
by really slow SMM calls.

Tested on a Dell Inspiron 3505.

Armin Wolf (3):
  hwmon: (dell-smm) Avoid unnecessary SMM calls during init
  hwmon: (dell-smm) Cleanup init code
  hwmon: (dell-smm) Warn if SMM call took a very long time to execute

 drivers/hwmon/dell-smm-hwmon.c | 50 +++++++++++++++-------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

=2D-
2.30.2

