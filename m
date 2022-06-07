Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAAF5407C1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 19:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349881AbiFGRvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347450AbiFGRfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5967710EA46
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654623002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Cd64zesxXwO9DDUxUPRw9NFg82m3SyiLm8HJHcXtYxs=;
        b=EwQhh1GWs+NSlGnRIt3oBdfVII2m5AN1KPc3oWfndVsOMQb2V3MS09eu3qRMgtDHORYUHw
        f4zS86Ip0irL26pwejhBAC/F/ibctbjP2l1jHnsP/0DcfmPDZBhyUzGa3pcHPDIROJphsA
        8NPcWn1WcASgdB7tiIrPxOu3+kbZLwg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-iqv0KzgbPQm3IeQVzHxfAg-1; Tue, 07 Jun 2022 13:30:01 -0400
X-MC-Unique: iqv0KzgbPQm3IeQVzHxfAg-1
Received: by mail-qk1-f199.google.com with SMTP id i5-20020a05620a404500b006a6d7a765d9so2031572qko.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 10:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Cd64zesxXwO9DDUxUPRw9NFg82m3SyiLm8HJHcXtYxs=;
        b=gajckhAjcTgHTDpmtHuHcD60+utFpn/pp0+slDKGuLrsefusoG0G6AeOnu9lvgvtbn
         mVMPAoGc2xtk/L3FnAzj9MlR7xo4XT2+7K/akCf0r69klYklsTw7zoie8ucnkN4zv+31
         d5QFBwFveb4KIGCdwi0tArnwgh5bjbpnV1IaeBVfEK4KHjymOzMLMiKP2aguZTsQNy9w
         TJAYl34F3aZNfmgAaw+qwmndyxfjN5r+wKo/S5wW/a6xmmfhEAhqBCd7XdrTLq1aStTw
         IO+cExfw/tfkkTtMWCo6YOUd6aqGRDdKZOAgTjtQLrgbGA7PAiKW1zZuspLF800iF+KY
         AKew==
X-Gm-Message-State: AOAM5325Fj9Ab5sgCdCIL9PtiQol3FvXhM+waH9cvxTLwx1/6ifVwYFD
        WepPFQmQkJZltEm/7uXAf0P9S8bKnEkgRsiOTuQmW8dchu/Q79F9mC6X/HracAAQTjBGVvp5aIs
        mr4/+jZ/tcS+UGA5qhsGE9cB5MwRb57YbYdpUQQr2
X-Received: by 2002:a37:510:0:b0:6a6:ab9e:1b80 with SMTP id 16-20020a370510000000b006a6ab9e1b80mr12714397qkf.770.1654623000847;
        Tue, 07 Jun 2022 10:30:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzBLb3AR0/c4UB2dMyC54NtqNuvP7ErFpaHdRPIuWyOScdvAhUmZE3B0ZcDDKCwgmCaug3oBt7gQ4WiS/BOaY=
X-Received: by 2002:a37:510:0:b0:6a6:ab9e:1b80 with SMTP id
 16-20020a370510000000b006a6ab9e1b80mr12714382qkf.770.1654623000642; Tue, 07
 Jun 2022 10:30:00 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 7 Jun 2022 13:29:49 -0400
Message-ID: <CAK-6q+gzQSbsfCEu5Gma_X7H16p0UipbK+nZeGNAqOi-czP+XA@mail.gmail.com>
Subject: ANNOUNCE: Linux Distributed Lock Manager Viewer
To:     cluster-devel <cluster-devel@redhat.com>
Cc:     David Teigland <teigland@redhat.com>,
        Christine Caulfield <ccaulfie@redhat.com>, rostedt@goodmis.org,
        tz.stoyanov@gmail.com, chan@mcs.anl.gov, gropp@mcs.anl.gov,
        lusk@mcs.anl.gov, song@kernel.org,
        linux-trace-users@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've built with existing open source software a Linux DLM (Distributed
Lock Manager) viewer [0]. The Linux DLM subsystem can be found in
"fs/dlm" and its main users are gfs2, ocfs2 and cluster-md. It is like
the name already propagates a distributed lock manager for Linux
clusters. A cluster can have shared resources among several nodes. DLM
offers to protect shared resources against mutual access e.g. cluster
file system gfs2 which operates on shared block devices among several
nodes. The viewer offers a graphical view about the used lock states
over time in a cluster.

Therefore we need to capture Linux DLM traces on all cluster nodes.
This is done by using the trace-cmd record command with the time
synchronization feature between multiple Linux machines which are part
of the DLM cluster. Another tool is dlm2slog2 [1] reads the recorded
Linux trace files, merges and converts them into a "drawable" open
format known as "slog2" [2] by using the open slog2 sdk. The slog2sdk
contains a viewer named "jumpshot" [3] which can be used to visualize
the slog2 file. Originally this drawable format was invented to trace
MPI (Message Passing Interface) applications, however it does not
depend on MPI and offers a graphical tracing for distributed
applications which I adapted for DLM lock states.

The only "missing" piece here was the convert and merge of the
recorded Linux traces to the slog2 fileformat. Hereby I would like to
thank all trace-cmd developers (especially those who made the time
synchronization feature) and slog2sdk developers which offered they
work as open source so it was easy for me to make a small piece of
software "dlm2slog2" that works as a bridge between trace-cmd/linux
tracing and slog2sdk.

As the slog2sdk is written in Java I did Java bindings similar to the
existing python bindings for libtracecmd, similar classes, etc.
underneath it uses swig. I would like to try to bring those bindings
upstream to trace-cmd. It's _not_ necessary to have a Java dependency
on trace-cmd, there should be some trace-cmd-java package available
which installs the necessary swig library libctracecmdjava that offers
jni access to libtracecmd. As well a jar file which can be seen as a
library/python module and follows the same license as libtracecmd. The
alternative here would be to maintain an out-of-tree trace-cmd-java
package. I would like to hear some feedback for it, the current code
can be found at [4].

If you want to get started or simply see what this is all about
inclusive screenshots, see [0].

- Alex

[0] https://gitlab.com/netcoder/dlm2slog2/-/wikis/home
[1] https://gitlab.com/netcoder/dlm2slog2
[2] https://www.mcs.anl.gov/research/projects/perfvis/software/log_format/index.htm#SLOG-2
[3] https://www.mcs.anl.gov/research/projects/perfvis/software/viewers/index.htm#Jumpshot-4
[4] https://gitlab.com/netcoder/trace-cmd/-/commits/java_bindings

