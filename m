Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C78548A09B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245338AbiAJUCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243444AbiAJUCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:02:24 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD067C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 12:02:23 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id h11so3722637uar.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 12:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+U0DyIqIB0Bf4/3JRRlP9EF8f0ETQTc0Wmkp/Mb/64=;
        b=DzC8kC/ku1j1Ab1a2zVeX27jPtl4vZrkRtfN//MRx2IYDUi9K1Rflt3RbueaA/VYDS
         OZkvldB5/WTC1UMjJ1GXCSrHxH6Lvwee85VglqaJdoYKNlP+v1y8OIMDqVP8Tyoj7J7/
         V8iE4QJdH7hDY3y4YvWmM6i8/aoU08sw6dm2swPk+V63VnlTJcl4+55dgLZTTnAeAby6
         sEt8Nl60swK6VFbkS4kyi56VKAMuRJM1omO1GEUPqpWoFd0kzdt7l8g8aizk7uSMLDOZ
         d46WGZoorFisW4ZbSDCQVR41E5BSz8XJ6ijtn69+rvNkp0yasv3M4aLzWuMBSYEgCtcA
         7+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+U0DyIqIB0Bf4/3JRRlP9EF8f0ETQTc0Wmkp/Mb/64=;
        b=cHIukvCNbHkuZE2eZ+uh+2LtaO2Ca74L7WNU8jYuA1/ZgNwrrPDAxniifrnmMpoSjq
         KsFfN4OPu7SAb5AcFhnntg2VLpy7NCrnv0cQxBlIdrniS+sR2GwXO6kDwBLvlpqoVKNG
         WcvGnJzk1pfjKZnky02WPRr80b8IOvg0msgDYgVHSaW8a0XWBE9S2MqjZMDU/YV808UR
         qGZfpcwH18W/hR/Rak9r3cq2tu/fc11tpx8Hb5ShbqBM57iINjv/lxryjjfv5ltVvtXW
         HaS8bh2o1zaGTLBJxtxTgyVXqDsp7Wjzxr5P1uBN6U5Y3UsApd48ziG520hbY6h5bkQS
         +lYg==
X-Gm-Message-State: AOAM533r3ROlxiS1OGKo/htmtGkp9hHV69mc+a3dBG21LnMl0SBFXXUi
        FlHZQ8V7lqyFcb5TxmqcLE8hjQbi1jceCg==
X-Google-Smtp-Source: ABdhPJz09WzDlkXUAn6XJQ250fOk4IffYTOXQOkXpY6OkcUHC3cSK0/6HTjcvHie1dcHkrDNTbyhMA==
X-Received: by 2002:a05:6102:3f07:: with SMTP id k7mr606477vsv.13.1641844942991;
        Mon, 10 Jan 2022 12:02:22 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:3a68:93ff:fe5d:d3e7])
        by smtp.gmail.com with ESMTPSA id y27sm3323733vkn.11.2022.01.10.12.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 12:02:22 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: Implementing overdrive communication in w1
Date:   Mon, 10 Jan 2022 17:02:59 -0300
Message-Id: <20220110200259.23276-1-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all

Recently, I had to use the w1-gpio driver to access an EEPROM w1 slave.
The problem is that the slave only supported overdrive speed, and
w1-gpio is using standard communication. I checked the delays and
confirmed in the Maxim website:

www.maximintegrated.com/en/design/technical-documents/app-notes/1/126.html

Back then, I changed the w1_io.c driver in order to support it, but I
want to make a patch to be able to choose between standard and overdrive
speeds. Maybe set this in the w1-gpio device tree, if the user wants
overdrive mode (adding "w1-overdrive", for instance, not to break the
already working standard speed mode).

Do you have some orientation in the path that I have to follow? I
thought I could add a parameter (bool?) in the struct w1_bus_master in
linux/w1.h, and test the value of this parameter where delays are used
in drivers/w1/w1_io.c. This is the best approach? How can I know if this
would break something?

Is there some effort to add support to this already that I could help?

Best regards,

-- 
2.34.1

