Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CBA4C0ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbiBWJIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiBWJIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:08:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D58F27EB3C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645607270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HUj0/NwUuJ7NHKgnroaaAJ8GqMUas2rpBLKSH+cv8pk=;
        b=bz7hdh7VEXvrncw13TSHEvqioxZ90QI/qa3PUNSvtQL5M/0FyXlFRbvJYsTgl20By4vis2
        ndJys1DJDHd1XKd+KifN5Edk//aU68V5kqbnysrmx6QOzWDBn+t64mY0V/rSOpIx6eCJQJ
        T876L07jSJOjLJF7GNkorD+/Iyk3gnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-9pY2HoO4NZS2quyPaJpHCA-1; Wed, 23 Feb 2022 04:07:47 -0500
X-MC-Unique: 9pY2HoO4NZS2quyPaJpHCA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 032761854E21;
        Wed, 23 Feb 2022 09:07:46 +0000 (UTC)
Received: from kate-fedora.redhat.com (unknown [10.2.16.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 390A87D420;
        Wed, 23 Feb 2022 09:07:35 +0000 (UTC)
From:   Kate Hsuan <hpa@redhat.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        Kate Hsuan <hpa@redhat.com>
Subject: [PATCH 0/1] staging: media: ipu3: Fix AF x_start position when rightmost stripe is used
Date:   Wed, 23 Feb 2022 17:06:47 +0800
Message-Id: <20220223090648.41989-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AF scene will be at an incorrect coordinate if the AF scene is set to
the right half part of the sensor.

After several attempts to set the AF scene to the right half part of
the sensor, the AF scene was staying at the rightmost edge of the sensor
for any x_start setting. So, if only the rightmost stripe is used, the
x_start should be adjusted based on the new basis of the coordinate which
is the down_scaled_stripes offset. Based on this, if the only rightmost
stripe is used, x_start should minus down_scaled_stripes offset to keep
the correctness of the AF coordinate.

Kate Hsuan (1):
  staging: media: ipu3: Fix AF x_start position when rightmost stripe is
    used

 drivers/staging/media/ipu3/ipu3-css-params.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.35.1

