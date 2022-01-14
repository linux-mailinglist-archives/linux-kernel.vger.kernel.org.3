Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC3948F22D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 22:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiANV5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 16:57:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229931AbiANV51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 16:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642197446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=0nYcbPjTNComuFfgHylDZVxbeAs7qUax44gfj+SO650=;
        b=SBuTBbnG2jfprTieSeqmfGOI4L/QvXwE20dIAOHduY6VWsfUBDVW35y0ITCUSUCHbr6Vg8
        m56sL+TETCCpU8tpCVSOwBmG1VuIEqnryZxBfcKnByulnVeeMvakiPn/2kjU1jJXF7fM6H
        9yTUfNP+2zyalqQjHAtPBN/ULjIoLiE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-8xVImg-uNiO3Helk3CIRDg-1; Fri, 14 Jan 2022 16:57:25 -0500
X-MC-Unique: 8xVImg-uNiO3Helk3CIRDg-1
Received: by mail-ed1-f69.google.com with SMTP id m16-20020a056402431000b003fb60bbe0e2so9262490edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 13:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=0nYcbPjTNComuFfgHylDZVxbeAs7qUax44gfj+SO650=;
        b=DIrDuhrI9o3NxAO+fORApjiVZXIWaYKm5uPBXcbPhHGWSHd/+PK9SCa9C1ectdwLio
         hYR66W5zKcjLkLcCSV7KwN1KMCWT7IsCtaeYIpndiMGCDeJn1rzIfQzwIuBbGnk+mOS/
         cyqmgmSH0BOAxLa1VW+o075G/QUl5XR1YCwaaO4dh+Afe9g760a84ZIoK2dgwBv54FZl
         wUuxLUaK3HNXoh2H5nYZQwvlUso09Twol1Yo7t/QiaaMaO1EDBk6XNytDIYND2cDuMhA
         JT2sdx8a6VaBcO9kuJUaf91PAtq9N/9ELh7JHq/ptLYN5HC9ihNNYT0jHmhUs8jvPSx6
         f4vw==
X-Gm-Message-State: AOAM5319vkeyqaD0HprGZ8/bZC7bhZRnWbaHKvkIDI8JoQXnVBOVB9E8
        ZHnGD8tg2GjPwpkFR+muQVXPiNlDxpc/fYKlUZ7o8hogAiDwZJogmoYn9sNLArWJ3yE/dfBa49x
        UDPBZd+FLD1EEFcK2ERkdpOjcAmLeUICHavZbLWWwzv/rCNE1p3cFx8d9yyDQnb8BDB6UyQ==
X-Received: by 2002:a17:906:eb11:: with SMTP id mb17mr8647895ejb.535.1642197444183;
        Fri, 14 Jan 2022 13:57:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAibQB9Y3gklX3arCEQC2FuudRK2ysR4ECmsMt/8aVZrPLBqArrrfecX1G9B3ooL45cyeyyQ==
X-Received: by 2002:a17:906:eb11:: with SMTP id mb17mr8647883ejb.535.1642197443938;
        Fri, 14 Jan 2022 13:57:23 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
        by smtp.gmail.com with ESMTPSA id j11sm2758814edv.0.2022.01.14.13.57.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 13:57:23 -0800 (PST)
Date:   Fri, 14 Jan 2022 16:57:20 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] virtio reset/device removal fixes
Message-ID: <20220114215641.239984-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an issue found by stress-testing device removal
of virtio console, as well as a similar issue found by
code review in virtio mem.

Changes from v1:
- added documentation
- added virtio mem changes
- missing new line in virtio console change
v1 Link: https://lore.kernel.org/r/20211005070354.265164-1-mst@redhat.com

Michael S. Tsirkin (3):
  virtio: document virtio_reset_device
  virtio_console: break out of buf poll on remove
  virtio_mem: break device on remove

 drivers/char/virtio_console.c |  7 +++++++
 drivers/virtio/virtio.c       | 16 ++++++++++++++++
 drivers/virtio/virtio_mem.c   |  2 ++
 3 files changed, 25 insertions(+)

-- 
MST

