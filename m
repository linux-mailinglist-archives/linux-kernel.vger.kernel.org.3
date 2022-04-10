Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A06C4FAB3F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 02:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiDJA7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 20:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiDJA7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 20:59:23 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B31E50
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 17:57:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u14so12027199pjj.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 17:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oO3gKMUvX749A0jVeOuTO8rfWxngzb9Uq1lafAPSmXA=;
        b=BpgQjlR/I+sOoICjCyz8qJ207y4EFIqd2KCvjyDIzpyJm5pJnrplvQn+pSAjx1GypQ
         5BQYcVInwD0QwIyRRYFUSZfUJqY23KlR6pU6MAWkZnOTkC4deqJx1R05NVcNxvLvkFcd
         YQw83Be8SXxNpauimLchPnOQJydC9huL3bzwItu1Qnms4oo6tCyEXAtLWJSI8Tk4udoK
         hYqpBrSMsMdq2NROmI5EmLLPQ2ylh3JOolWEnBxxwPabhZKrD9O15HD50jn04n0rx1Wb
         9H/XqIGsMkGz8kayjlajGHiUEZeWQV66jqMEdfWo886y5RRUIzvDm8ZxgYbEYo9UPysp
         c9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oO3gKMUvX749A0jVeOuTO8rfWxngzb9Uq1lafAPSmXA=;
        b=F0AYxJdYWrKEehaQUebS9MNUWWaWUBcvxiXGSr34bltM0hSOZIRg+WznEIvPGRkfWk
         gwXW6yynPx09XpgCz2RcOePlHG0Co/DxWJybG3Ej8zYWv0k4r5OcqNfXj99MuIZBHlmw
         5I08SOreNtfCr93oJJiStgRN92OMuc8yYwWvpUiQdwf9Lw8MhP61uPezW1jm+SRFvS+/
         fsp2Wzot8gBcUDUEbCMOiUiGrBVC0K65eazw2EMmqntSDdVfwL7LiSLMRs5TeJTiYVfi
         XDSMskvaPIBcJgbwJq4E6s9R90mGQPiwg5d+aWwatJRiZt4CvchdsVaC6QjopSUXR0ga
         JhCg==
X-Gm-Message-State: AOAM532+6E/XF4EtoMUgTVrsqiQSAEXPx/XLGLYGLUEJ2BdraX0Lbbiz
        cfnEL+ZdjE/P2eHgiOa1ANo=
X-Google-Smtp-Source: ABdhPJzvDWwo+bUFSDDyJIph8wi0hMWq8tzhcTnGmp213taWRFOz+NbA46zX4zKu8ulHO8SOBzMH9A==
X-Received: by 2002:a17:902:ea0a:b0:157:31:e828 with SMTP id s10-20020a170902ea0a00b001570031e828mr16739525plg.19.1649552234211;
        Sat, 09 Apr 2022 17:57:14 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:172c:26af:268e:6e9f])
        by smtp.gmail.com with ESMTPSA id l67-20020a633e46000000b003986e01e982sm25088215pga.67.2022.04.09.17.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 17:57:13 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Duoming Zhou <duoming@zju.edu.cn>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/4] xtensa: iss: clean up network driver
Date:   Sat,  9 Apr 2022 17:56:28 -0700
Message-Id: <20220410005632.3925219-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series cleans up ISS network driver and fixes potential deadlock
reported by Duoming Zhou <duoming@zju.edu.cn> here:
https://lore.kernel.org/lkml/20220409055135.54921-1-duoming@zju.edu.cn/

Max Filippov (4):
  xtensa: iss: drop opened_list logic from the network driver
  xtensa: iss: replace iss_net_set_mac with eth_mac_addr
  xtensa: iss: clean up per-device locking in network driver
  xtensa: iss: extract and constify network callbacks

 arch/xtensa/platforms/iss/network.c | 150 +++++++++++-----------------
 1 file changed, 59 insertions(+), 91 deletions(-)

-- 
2.30.2

