Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257BC57EB7F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 04:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbiGWCO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 22:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237078AbiGWCOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 22:14:19 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61634550DE;
        Fri, 22 Jul 2022 19:14:18 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id h22so4755360qta.3;
        Fri, 22 Jul 2022 19:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to
         :content-language:cc:content-transfer-encoding;
        bh=ovEPdVNPYrXXh2A+ZkbYsEioSDa7kIUraIugB/1objM=;
        b=gNJcnF6MTFZiZJSBTgHyZ0TjUz/zgncrpKZvc15a2Kc+eqUNLYcox32Lu/c1lfjePy
         fYZNngswlg4O/piLK+E0CQutPIfCCk2P4o4uxP+pb8G7WL3/zag9FeD2SPJ5Tamv8YWa
         6zlHE7iqcF8flTU3E96hlX8iEzoCLz31bukHahMA4Pp1JSjlvMxnKNtGqzdFhGp7VuhC
         sVasWEvik0ziGBLJfEUv8Ku+Cd+WAQhH7S3xTVLRsl3JY9zWYVhckNu5jAShxDMUYcM1
         mpdJDghol3EcjvM0HLZ0xGeytSU7LJq071rZIS0RE277PVzwe6Gn/ANbD3lw6yqDHbvR
         UPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:content-language:cc:content-transfer-encoding;
        bh=ovEPdVNPYrXXh2A+ZkbYsEioSDa7kIUraIugB/1objM=;
        b=Nu3RmTFRsAbY4++Pm82FQCsgGAZba50R0WaKxxdMSv7Lbjns695veCEA2KEHOd8wHy
         ayRklUWQaVjj6b/PEww70Xa/m0Ni3MFy9kjiiWrmpWRB6vaXFiOt8gMkbjw+B9eiDbfN
         XI5+9m2WUXFJx3KC7iO6is8Epo4SrWOkArFF7hr4+tjxCWJrOQcEjgg7fSsg7pp6SlgC
         M1SDZ8B0K9Xu2kw9ap4l/e2tKQpqCpyhv0Ikj1uxcD7pGD+RxUUxxrhoGflk5ajW5Vyn
         Iue3gqKflXcFZtgFwfTz2LSM8oL8beD2ry/sy0OOiJ4jWXjcgn53yIJhNOe0ahhh5gJV
         W+9Q==
X-Gm-Message-State: AJIora88ml+cZg78Hw4QvlsckijsHY6pi/pKcrJVSmakmxN/DRBv8D12
        sT0uuDWZHnRrvA6LtRrluAvE9D7/y7Q=
X-Google-Smtp-Source: AGRyM1uQ6h/6Yr0Y7bGOvdSnNXZp/qko37yNcpsbVYpjNYBbp3KQ9VcFbib4Ru9TVS4Z+c+ft3dP1Q==
X-Received: by 2002:ac8:5f89:0:b0:31f:1fc4:d3e6 with SMTP id j9-20020ac85f89000000b0031f1fc4d3e6mr2628871qta.504.1658542457534;
        Fri, 22 Jul 2022 19:14:17 -0700 (PDT)
Received: from [192.168.0.9] ([198.179.6.194])
        by smtp.gmail.com with ESMTPSA id o7-20020a05620a2a0700b006b5683ee311sm4946999qkp.100.2022.07.22.19.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 19:14:17 -0700 (PDT)
Message-ID: <9e16d503-2203-57ed-d6af-61fea0c3e10b@gmail.com>
Date:   Fri, 22 Jul 2022 22:14:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Stefan Hansson <newbie13xd@gmail.com>
Subject: PROBLEM: Regression likely in hid_uclogic driver breaks Huion
 Inspiroy H640 drawing tablet
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-GB
Cc:     newbie13xd@gmail.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Somewhere between Linux 5.17.6 and 5.18.11 the Huion tablet I have 
stopped working properly. In GNOME Control Center it is identified as 
Huion New 1060 Plus, however that's a different tablet than the one I 
have. Mine is a Huion Inspiroy H640, and it uses the hid_uclogic driver.

With Linux 5.17.6, the tablet works as expected with all the buttons 
being detected and the stylus being usable. With 5.18.11, the buttons 
work fine but the stylus does not work correctly. The first time I 
approach the tablet with the stylus it works properly, i.e., the cursor 
on my screen moves around and follows the stylus around the tablet as 
expected. It continues working like this until I remove the stylus from 
the tablet. After I remove it from the tablet, the cursor never gets 
controlled by the stylus again. I can see that the tablet detects the 
stylus (it has a small indicator light), but the cursor doesn't move 
when I approach the tablet again. To clarify, with Linux 5.17.6, the 
cursor moves around just fine when I remove and then put it back to the 
tablet, just as you would expected.

It may also be worth noting that it worked fine when I previously used 
it around six months ago, although I'm not sure what version of Linux I 
was using at that time (whatever Fedora shipped back then). I also tried 
reproducing it with yesterday's linux-next and Linux 5.19.0-RC7, and the 
behaviour was the same as 5.18.11. I am currently trying to bisect this, 
but it's not going very fast as I currently only have access to a dual 
core laptop from 2014, so building Linux takes a good while.

Regards,
Stefan Hansson
