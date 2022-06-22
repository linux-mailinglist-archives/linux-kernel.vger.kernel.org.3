Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C589B555369
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376484AbiFVSoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiFVSom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:44:42 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C631C93F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 11:44:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r7-20020a1c4407000000b003a02cc49774so182802wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 11:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=qj9BmjfCYh4t8kc8HY9ly8TW6zCO9Zg9lpxevaODVZ4=;
        b=EBfwZoCLRNc5XJCiSsJAdD8NMyfycgTudIArUh1G8NxrMoUDBoSIKM4f/mNzCVJN5F
         7wQYWnBfovU477qHfR0aB5d5rHuzW7l8mAdYmsLkfL4vIxJnj34lWyxMJOq6Xia04bZn
         hs7h6vbFpsRXJ9N6O4zepzk/RVPBYYkP1RSqsU6eiG79tGnSXwhk4drwLJqCSA+ZixPo
         y1UI43Cu41ZIo3qJRfMGOuRRzfr5v2yUNYSxRMd8yqkLRzxkcf/mcxnzLVskoXJgi2rP
         mA/CsqakT9Ex6B6j7SrmyZ70TLGXlcy3p/ivg+Gvru3Hxt8AsqVyd5OWq1P8YRsbFTT6
         oecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qj9BmjfCYh4t8kc8HY9ly8TW6zCO9Zg9lpxevaODVZ4=;
        b=nfM9b0QMt40U6KGelVGQvJT3GHXi78t0Z2d4CYbr/+xJJGYuH4aEtWgC2V2OKduLxZ
         i7rTLUHKTxiEqS7Hg3x96IVBxLCcxwKlTdOs8rfub3qE5cUuqlQKNwMXbgbcV4blp3wv
         wsHjPaWRQBMwwAiNyZWrDR6oHLlYu9vyfYw81CMRLMONYPNgO+d79TnKnFRXMUUduhTE
         f+tQgiva2KbfzPHSDnK2SmlfcgnMyEKqMW1BOHkqqMETcAvZ0VZyZsdCxh9cZYvrvza/
         dzhba8pz5OzBtQmKU+MGlkc6yrxwcI6ysl6SYhEXfZcuV3IITLUFJMVJgFS8iwMVnaRL
         9eIA==
X-Gm-Message-State: AOAM5339lEXgzLFyetvixLHTISVaKw3j8hHMbc//J72y2CkVmyAMjDts
        yc8v3NriUU981hUZEnvWwOukq4Xq0tPIlWk5SNbRUo+r
X-Google-Smtp-Source: ABdhPJzf7kp7MQMkTqXVfRfysHHI4B3z84Q33DiiaTxina+ma/6waGcEy1KTkBU/IbPxd6H2COMx7GUAqVf7CR6+LTQ=
X-Received: by 2002:a05:600c:1906:b0:39c:7f6c:ab3e with SMTP id
 j6-20020a05600c190600b0039c7f6cab3emr47163547wmq.205.1655923479737; Wed, 22
 Jun 2022 11:44:39 -0700 (PDT)
MIME-Version: 1.0
From:   Constantine Gavrilov <constantine.gavrilov@gmail.com>
Date:   Wed, 22 Jun 2022 21:44:28 +0300
Message-ID: <CAAL3td1_ioCy=hO+hLmo5JpZ=WnfHKvaEtS0JQdk=-tb-hQEZA@mail.gmail.com>
Subject: sendfile(), splice() and vmsplice() questions
To:     linux-kernel@vger.kernel.org
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

I would like to clarify the behavior of zero-copy TCP sends with
sendfile() and splice() APIs
Assuming the zero copy socket option is set on a TCP socket, and
application is using a shared memory mapping of /dev/dax device or a
file in /dev/shm or /dev/hugepages, will zero copy be used when:
1. sendile() sends multiple page aligned fragments (4k aligned start
and 4k aligned size)?
2. senifile() sends multiple page aligned fragments(4k aligned start)
but the size is not 4k aligned?
3. sendfile() sends multiple fragments but the first fragment is not
page aligned?
4. If a pipe was populated with vmsplice() without SPLICE_F_GIFT, will
splice() from the pipe to a socket will do zero copy?
5. If a pipe is populated with small buffers (headers) and full pages,
will splice from a pipe to  socket will do zero copy at least on full
pages if the transfer spans both? What if the splice() falls within a
partial page (non-zero offset or size of a fragment less than the page
size)?
6. can vmsplice() populate the pipe with zero copy at least on full
pages, if it is given an iovec of headers and full pages?

And regarding completion semantics:
1. Is it true that splice() and sendfile() on socket will return when
the data is "written" to the socket buffer? If true, is there an
indication in the error queue about "wire" completion (as with
sendmsg() with MSG_ZEROCOPY)?
2. Can I use send() before and after sendfile() and know that the
order of the packets in TCP stream is preserved?

I assume that vmsplice() still does not work on sockets. Was there any
work done to provide an equivalent interface on sockets?

Much thanks for your answers.


-- 
----------------------------------------
Constantine Gavrilov
Storage Architect
Master Inventor
Tel-Aviv IBM Storage Lab
1 Azrieli Center, Tel-Aviv
----------------------------------------
