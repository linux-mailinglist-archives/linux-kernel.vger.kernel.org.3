Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A154818D4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 04:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbhL3DFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 22:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhL3DFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 22:05:02 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0658AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 19:05:02 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id z3so17280153plg.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 19:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:date:subject:from:to:cc:message-id:thread-topic
         :mime-version:content-transfer-encoding;
        bh=HCfAlaMSnvj/DFkWkfTZyPmms6cxrAZFM9yr8MI4h0g=;
        b=orU3//Aqyh3NX4ouVn1NMsWTBEQmnZZVvXbgPVju2+uAZDOEb51avmwXBF8rN1RaE1
         BwtO99nYcKpvIHZiTTIQlVdLFiLmgQvCVXx1fb5Fv/JExyXsquCQ80Rwvk3I8GSOsmnE
         b4SP2Nv01TFo6e1UnONNcJXqyFD0dYcLIqKvTpfSSrRAFy6RAIdZbu2L2/Cvl4xA/nzG
         Uly6iuwGlqzGD52y+xuuRNqE838H0nSyUUaj2dJANEcfLSs7REvOYjdMYbYuJexLAUCg
         WRwVR8W4iZQzjnhvb9ltWAnpPuXO7Xc9skNFz24pVI97BDr0jIZkFmKVQMcNnP8/LjTo
         bBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:user-agent:date:subject:from:to:cc:message-id
         :thread-topic:mime-version:content-transfer-encoding;
        bh=HCfAlaMSnvj/DFkWkfTZyPmms6cxrAZFM9yr8MI4h0g=;
        b=Hrxe+xk+vJ5VJPguugTDY/bbOwxJxvcQOG7ZyWaQ0acVGjHZ6ZiQyTENnMSeN2/YfH
         4FR6mu9Ls3u4tHPoAnH54GQngMGNv5KasFOrG1b9Fy4IpGZqhlf6Q9JFNbU/P0gOLfUX
         oRoTwQG6J9drYMsMc5TqSCrcrrP8WiqF04GxJKVHzBwFMe5APkpJFkb1/ttvFhDJoTMz
         LrENX7ULLRAgnjLwsQlcDE8ZAEAQ6mEH7u2eTn2uvaAxmdXCF8uVvrPsE1gcp7E8gaCo
         UEWfB3fGmWUQlE734ZlP22Xx8wu7G3DCrx58PCx5tApZhfkRq2wUfQz6DnCLb6vTB//+
         lB9A==
X-Gm-Message-State: AOAM531SGof7qRAaFXHi09+lr6nkVFC5GrcH34UkYs7IvuBHrY9GQmfE
        spwP4cKFwQl5u0tJ7qpthizR/9VrReGAnuk8
X-Google-Smtp-Source: ABdhPJzxJDtWcvuTpn1CK+S66A9+rQU5T//Z8yghimRfZ2yj4faYVPbAohuKVLNZ3g6JH1wWzLMMVA==
X-Received: by 2002:a17:90b:3e8c:: with SMTP id rj12mr28208190pjb.184.1640833501548;
        Wed, 29 Dec 2021 19:05:01 -0800 (PST)
Received: from [30.135.82.251] ([23.98.35.75])
        by smtp.gmail.com with ESMTPSA id l186sm20827387pga.24.2021.12.29.19.05.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Dec 2021 19:05:01 -0800 (PST)
User-Agent: Microsoft-MacOutlook/16.56.21121100
Date:   Thu, 30 Dec 2021 11:04:58 +0800
Subject: [Resource Leak] Missing closing files
From:   Ryan Cai <ycaibb@gmail.com>
To:     <greg@kroah.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>
Message-ID: <5C277DBF-B1EF-4193-9983-63105E5BC053@gmail.com>
Thread-Topic: [Resource Leak] Missing closing files
Mime-version: 1.0
Content-type: text/plain;
        charset="UTF-8"
Content-transfer-encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel maintainers,
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 In=C2=A0linux/drivers/zorro/gen-devlist.c, the file opened=
 at Line 39 may not closed when going to Line 65.=C2=A0
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I think, return 1 at Line 65 should be goto error. Shoul=
d it be a bug? I can send a patch.
=C2=A0
Location:=C2=A0https://github.com/torvalds/linux/blob/5bfc75d92efd494db37f5c4c1=
73d3639d4772966/drivers/zorro/gen-devlist.c#L39-L65
=C2=A0
=C2=A0
=C2=A0
Best,
Ryan
=C2=A0



