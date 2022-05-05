Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBD651C5A7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382350AbiEERFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344870AbiEERFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:05:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BD35B3DC;
        Thu,  5 May 2022 10:01:52 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so3006973wme.3;
        Thu, 05 May 2022 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:content-transfer-encoding
         :user-agent:mime-version;
        bh=WdAvXMilkjeXGxCjt4xSahrQ1dbVlNr+hNx2Eah+WlM=;
        b=hTNmdPYIZqmJ813s+jCFPFG2FxNmfsZ1OymxifcGYmreRrJs6FAySX+Z8IlZ5qxpcX
         V3QWT2s8/IsLlbXcnNM8SL9NsLo1XKhBgS9UZuyXYk7cPVrwMWQyJJB/L+yfRepwM8e9
         KHl4uL7I/3cyXenNxV6FWEryxat4r1bg6E46kkj0vtEvDBBJm4E/B6ux8ak9MlOq9biI
         4mYzdf1WfB4+iVRc8jVtaNyY68o/m8gfFsZ87CW3q+Q1Z2MI+6Ms2bXDjLu8Po24hPc8
         aXKIpYyxq+kQuDokdWomLpkAl6/bU+GLb2ZExxsHJQTg6TDWcjKpmpCVpf3QVE3SGOgO
         sZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date
         :content-transfer-encoding:user-agent:mime-version;
        bh=WdAvXMilkjeXGxCjt4xSahrQ1dbVlNr+hNx2Eah+WlM=;
        b=AqO330shtCkFNr4P/yXzQxQekrB8dFO679MPsfvD7ToVbbVC8GMA5UzQB1U9mspBhW
         DU5+EgqSmDXqcKIa7FCEXMTX1pUx/Gdm1P8N/RkX2j8Q9gqhP0rwp3BxHyxQKUgHo1Zw
         SMEbjMb1fsyR1quU/3j5E2/qOc0y/g4LDJOJaWvT6q5ylwgwxwVCJyAoPpS7KVueeCMe
         knREJ5HGT66iDAlH520QyINk+3UE5VZPpsRpZcZehhwF3y8C2+GSDOrI04hSfTGaOouz
         QMbQq3NGO+k4cDRL++2m3Kcm45MKY+AG15N+uLL7U6zGmIsUvyPm7dAGZYRtm4RVJ3L/
         JZsw==
X-Gm-Message-State: AOAM532RDh3pf/iHvMsbQp8w/TdguWw+ZOBG1u9gQXPlnUF2gHXy4OMg
        RogiUJcFPrEzJB8jRydZHIuJjphISeU=
X-Google-Smtp-Source: ABdhPJwGhkNOC7bMhu95RxFbVVMEfYOF2frj3xLBCZmE2FFo4w9Rz+9PZHPCh0N0pN22TBVrX7RUyw==
X-Received: by 2002:a05:600c:4fc6:b0:393:fb29:1f3f with SMTP id o6-20020a05600c4fc600b00393fb291f3fmr5964866wmq.60.1651770110800;
        Thu, 05 May 2022 10:01:50 -0700 (PDT)
Received: from [192.168.11.155] (94-21-221-167.pool.digikabel.hu. [94.21.221.167])
        by smtp.gmail.com with ESMTPSA id g6-20020a056000118600b0020c5253d8d6sm1644791wrx.34.2022.05.05.10.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 10:01:50 -0700 (PDT)
Message-ID: <052a814001aaa46eab844f1d9693ddd9d731c164.camel@gmail.com>
Subject: 9 bit serial / non-blocking TCSADRAIN
From:   =?ISO-8859-1?Q?Baltaz=E1r?= Radics <baltazar.radics@gmail.com>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 05 May 2022 19:01:48 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I want to use a raspberry pi's serial to communicate over a protocol
that uses 9-bit characters, so currently I'm using the stick parity
mode (CMSPAR) and toggling between odd and even parity, then using
tcsetattr with TCSADRAIN as the second argument, which blocks until all
bytes are transmitted. Is there a non-blocking api to do the same
thing, so I can use it from poll / select? (If there's a better way to
do 9 bit character size, that'd be even better. For my protocol, the
9th bit is only used to tell address bytes from data bytes, so I don't
have to change it often, so I guess my current method isn't too
horrible.)

Thanks!
