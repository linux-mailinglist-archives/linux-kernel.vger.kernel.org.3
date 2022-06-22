Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2106D55428F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356889AbiFVGIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiFVGIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:08:53 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171E51CB21;
        Tue, 21 Jun 2022 23:08:53 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id o23so10928834ljg.13;
        Tue, 21 Jun 2022 23:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=S7mjpK/M+Dj2QUAMVzQMxy95Nz35P2kWVi4qmBs9FaI=;
        b=c8zZsZw4yF2vD84Jltja4RRpT8reCc8d2zsGZN+JAw2NKxHlnoRrcjI9V34HOhYhrq
         yJybnHfegsg7hw3BdOmAgjmocK5GbfRu2BiUJKZUtSC7De/YGZoi+T0W5JtjTeHNAirH
         plrQKjHHERe62ewez8bYjDlUV46Cwb5hoaq6AXfSSU3aTs7xeQF3uwWQTSHmVSZf1aG+
         ztzA8kjRd6Zr5zX2pAmYig55b8hX5lU2YLFzj7beYA78qmjkgJ7E62dx08/9Jz5UUXVZ
         Pf0zQpKOjXk1Dg+Z59xiB10nXn53xZrq5mNNn+RJ9peIGLXbbdFjgNy4eDhPVI9DCD9q
         nGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=S7mjpK/M+Dj2QUAMVzQMxy95Nz35P2kWVi4qmBs9FaI=;
        b=Zcu3ykLrjeew5KQaXB3bOBkDLQFAxTbxBynBUApTgkTHhKjaUIQNCAUW+IaY7PaMCC
         AYQmx+F0A0Axalb1bNf64+hwVy7RM+DnQBc2mVnJFDPai8pKLWNCG6X8HfIOOXWkfEIE
         Jjsqj/CNn6b8MhHS9ZYr99ND3LqZq3GRnb2aRfVVRMo4r7iEBzjb/PnCxs8bOmRSEvag
         K1KlbhIOsGO8uMXOQIXPcgHDTfT4huQ0tP3SjoVhG0PR3DajSXWcwwAeVhtT9MBJcOjl
         1IGxiqPz+Z0/8t40TUJnVHRqtScSZ5086FXiVxCpBjL9FSaz2v4q/nnJqwJ3Imc5wHjn
         fIrQ==
X-Gm-Message-State: AJIora/1lcmhCUxsIrNqyhXIMgATKE1f1fXMVZ8zTXQVZdDiDuDlABbn
        3eiQhWb2VnhlpvJjR+h2WGnGitGpieb0pBxFWXozkLF8m/o=
X-Google-Smtp-Source: AGRyM1vrxPgqDsyEq10YQi7/hA0k/MFiCT6W4kGM/zAv7zqFDWew9S1J/2y1HFNsMJX+ZjPKyZrUt2lxRoprmaXzj2g=
X-Received: by 2002:a2e:a90c:0:b0:258:edc3:4d2b with SMTP id
 j12-20020a2ea90c000000b00258edc34d2bmr956668ljq.225.1655878130979; Tue, 21
 Jun 2022 23:08:50 -0700 (PDT)
MIME-Version: 1.0
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Wed, 22 Jun 2022 11:38:39 +0530
Message-ID: <CAHhAz+jSYb6=x89oFin=AHBrNhg_Q61YQvanb=2ZGkZBDiLyiw@mail.gmail.com>
Subject: Linux: Use-After-Free exploitation
To:     linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Use-After-Free bugs result in kernel crashes. If these bugs result in
kernel crashes then how is it possible to exploit this vulnerability
for local privilege escalation?

-- 
Thanks,
Sekhar
