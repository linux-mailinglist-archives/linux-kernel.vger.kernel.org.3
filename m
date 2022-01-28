Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8C849F4E1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347167AbiA1IGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237542AbiA1IGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:06:32 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C032BC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 00:06:31 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a8so13245314ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 00:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nuNqyV6I50dd85AMCad10g9jypm9x0TneXnEG7ThEVQ=;
        b=KzR/YTPp22CZq1d4oZb+5h3agMmrBQLQ4Dz/A8uM5qkccqNW0tUmakMqE1J81EvnDE
         I+//qu9w6owbtTR71o6MnOdubM/5EkiuGShFnejuyM8ZXdygSINju8GAC9P2p7muuLJA
         nZ56g/1+R7P6nh1f2lD699Erq9t5YRv/Q0gIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nuNqyV6I50dd85AMCad10g9jypm9x0TneXnEG7ThEVQ=;
        b=D+N3BK0B1nBljiOS+VizVQWWKKx3SdGo6x72xISlg7g00cD918jUSi5HRUiAVW7QOT
         q0YxYVVYdjZugTbcparHAMLyx9WXb141FqNoGP3nZdChhp2ZbCmCa6K5En5Jf2gbmHY2
         nJzHmVrVrrpTpOcpSfoDPB5f39dJviTMk4iPWZJ14Gqo4AoBwL/CVjbGXm9pDREsaMti
         Gs6jFn4WrJzoUW91Njx37YwrZhi8NbxRqiKjk0ZEUKJOUYs/bq+InUB5ejVFNh0xa8TN
         HWQ11Yt7plIFEpyE7Wl0cw8kN0lQialdijlVpF2S4I5FOpqvNRk+GCMXDpNYx5zHIfxB
         pdOQ==
X-Gm-Message-State: AOAM531IsEvmuh7PM5a0hGoKjsabI/L8lAvZsrWcj8UfFQyzI38HCjpK
        jssNycg4vAfqEA46X6I9a6InOviyONUwSGZ9
X-Google-Smtp-Source: ABdhPJxXCssRRxHMd/1LSTr5uI4ArE46Q6jt93sflhJkh5SwVZ69D4hmMDlsxKjwLcrQ/+0IaSZHgA==
X-Received: by 2002:a17:907:8a27:: with SMTP id sc39mr6068063ejc.314.1643357190211;
        Fri, 28 Jan 2022 00:06:30 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id g9sm1323658ejm.152.2022.01.28.00.06.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 00:06:29 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id m26so1285975wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 00:06:29 -0800 (PST)
X-Received: by 2002:a05:600c:1912:: with SMTP id j18mr14547193wmq.155.1643356845250;
 Fri, 28 Jan 2022 00:00:45 -0800 (PST)
MIME-Version: 1.0
References: <20220128065310.GF8421@xsang-OptiPlex-9020>
In-Reply-To: <20220128065310.GF8421@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Jan 2022 10:00:29 +0200
X-Gmail-Original-Message-ID: <CAHk-=wgT6wuBB=pK2bGNQbioNCdJHT8Jnvs+4oT25jX1JFyhgg@mail.gmail.com>
Message-ID: <CAHk-=wgT6wuBB=pK2bGNQbioNCdJHT8Jnvs+4oT25jX1JFyhgg@mail.gmail.com>
Subject: Re: [ocfs2] c42ff46f97: sysctl_table_check_failed
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Antti Palosaari <crope@iki.fi>, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        David Airlie <airlied@linux.ie>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Kees Cook <keescook@chromium.org>,
        Lukas Middendorf <kernel@tuxforce.de>,
        Mark Fasheh <mark@fasheh.com>, Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Qing Wang <wangqing@vivo.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stephen Kitt <steve@sk2.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jani Nikula <jani.nikula@intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Content-Type: multipart/mixed; boundary="0000000000000063d405d69fd5be"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000063d405d69fd5be
Content-Type: text/plain; charset="UTF-8"

On Fri, Jan 28, 2022 at 8:53 AM kernel test robot <oliver.sang@intel.com> wrote:
>
> commit: 46e33fd45a52bf03769906e64d8a8a1ab317777d ("ocfs2: simplify subdirectory
> registration with register_sysctl()")

Well, it's apparently commit c42ff46f97c1 ("ocfs2: simplify
subdirectory registration with register_sysctl()") in mainline now.

What worries me a bit is that the commit was auto-generated, and when
reading the commit message it reads as if it wasn't supposed to cause
any semantic changes at all.

Is the cause of this that 'nm' is supposed to be a directory, and
register_sysctl() doesn't handle directories?

I don't know this code at all, should it have been simplified even
further with something (TOTALLY UNTESTED) like the attached?

                 Linus

--0000000000000063d405d69fd5be
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kyy482md0>
X-Attachment-Id: f_kyy482md0

IGZzL29jZnMyL3N0YWNrZ2x1ZS5jIHwgMTMgKy0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9vY2ZzMi9z
dGFja2dsdWUuYyBiL2ZzL29jZnMyL3N0YWNrZ2x1ZS5jCmluZGV4IDczMTU1OGE2ZjI3ZC4uZGQ3
N2I3YWFhYmY1IDEwMDY0NAotLS0gYS9mcy9vY2ZzMi9zdGFja2dsdWUuYworKysgYi9mcy9vY2Zz
Mi9zdGFja2dsdWUuYwpAQCAtNjYxLDE3ICs2NjEsNiBAQCBzdGF0aWMgc3RydWN0IGN0bF90YWJs
ZSBvY2ZzMl9ubV90YWJsZVtdID0gewogCXsgfQogfTsKIAotc3RhdGljIHN0cnVjdCBjdGxfdGFi
bGUgb2NmczJfbW9kX3RhYmxlW10gPSB7Ci0JewotCQkucHJvY25hbWUJPSAibm0iLAotCQkuZGF0
YQkJPSBOVUxMLAotCQkubWF4bGVuCQk9IDAsCi0JCS5tb2RlCQk9IDA1NTUsCi0JCS5jaGlsZAkJ
PSBvY2ZzMl9ubV90YWJsZQotCX0sCi0JeyB9Ci19OwotCiBzdGF0aWMgc3RydWN0IGN0bF90YWJs
ZV9oZWFkZXIgKm9jZnMyX3RhYmxlX2hlYWRlcjsKIAogLyoKQEAgLTY4Miw3ICs2NzEsNyBAQCBz
dGF0aWMgaW50IF9faW5pdCBvY2ZzMl9zdGFja19nbHVlX2luaXQodm9pZCkKIHsKIAlzdHJjcHko
Y2x1c3Rlcl9zdGFja19uYW1lLCBPQ0ZTMl9TVEFDS19QTFVHSU5fTzJDQik7CiAKLQlvY2ZzMl90
YWJsZV9oZWFkZXIgPSByZWdpc3Rlcl9zeXNjdGwoImZzL29jZnMyIiwgb2NmczJfbW9kX3RhYmxl
KTsKKwlvY2ZzMl90YWJsZV9oZWFkZXIgPSByZWdpc3Rlcl9zeXNjdGwoImZzL29jZnMyL25tIiwg
b2NmczJfbm1fdGFibGUpOwogCWlmICghb2NmczJfdGFibGVfaGVhZGVyKSB7CiAJCXByaW50ayhL
RVJOX0VSUgogCQkgICAgICAgIm9jZnMyIHN0YWNrIGdsdWU6IHVuYWJsZSB0byByZWdpc3RlciBz
eXNjdGxcbiIpOwo=
--0000000000000063d405d69fd5be--
