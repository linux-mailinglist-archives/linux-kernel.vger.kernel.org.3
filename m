Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E64564C31
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 05:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiGDDvK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 3 Jul 2022 23:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGDDvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 23:51:09 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BEB26D9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 20:51:08 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id j17-20020a056e02219100b002d955e89a54so3654244ila.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 20:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=M9hRqb3WYRYHCd7rlUoemaW11e5ur7i6TDtv0bzQBqA=;
        b=GehWl8YaUFeWpDxtxFhAPDHBXqlsskKtcEbJD+rzgEnIiyWi85aJawvVooBlgealLp
         5h7EgT27VgPIGEHuv6RxPoyMvvX/qvutvvvSv4aTBAFQwdJvOja2dTbLearcKvuevMii
         XcVTT0Vc2mqp5pUa4gvyALY9rFYHCsbpTY+Pam6FGZhMuphHVPnJD4jCF7+a67w2pMcC
         +uvKTRaCkjWig6z+9Kohx6ml1Kc2icPknfvfDzqHie6w+tnsL0Sj47MNp/DNWbrrl1EX
         M4grphk07+ZoIj0ESjRDB8oN1JvsvjtbfJIvy/SQMg+iT2b0N1ZciWF4vqK0v52rOxPu
         yC4Q==
X-Gm-Message-State: AJIora9nJwd72dJJG4tOI95Vr5qxs7f6NIjyAlTDUC4JAJJgiie9qfmQ
        yr4UkKxD/uve+Jo2ep3MFurYG9peMOSTLzcLIOvg7E5jcr8K
X-Google-Smtp-Source: AGRyM1vC5gpGPJNyNifpbI+j3apf76ToZ9mNn8w5Klt0NAXCY/kTe4DwtNvIqx6C8rsTkRlO6wLJE0DFLl9yJY3Iy0TcsXr9VlKI
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22cf:b0:33b:fd4a:122b with SMTP id
 j15-20020a05663822cf00b0033bfd4a122bmr16620229jat.244.1656906667381; Sun, 03
 Jul 2022 20:51:07 -0700 (PDT)
Date:   Sun, 03 Jul 2022 20:51:07 -0700
In-Reply-To: <20220704034230.1767-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055d99605e2f2a5d3@google.com>
Subject: Re: [syzbot] INFO: task hung in do_read_cache_folio
From:   syzbot <syzbot+be946efe33b2d9664348@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to create VM pool: failed to create GCE image: create image operation failed: &{Code:PERMISSIONS_ERROR Location: Message:Required 'read' permission for 'disks/ci-upstream-kasan-gce-root-test-job-test-job-image.tar.gz' ForceSendFields:[] NullFields:[]}.

syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.17"
GCCGO="gccgo"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mod"
CGO_CFLAGS="-g -O2"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-g -O2"
CGO_FFLAGS="-g -O2"
CGO_LDFLAGS="-g -O2"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build1089749838=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at 1434eec0b
nothing to commit, working tree clean


go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=1434eec0b84075b7246560cfa89f20cdb3d8077f -X 'github.com/google/syzkaller/prog.gitRevisionDate=20220629-111539'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=1434eec0b84075b7246560cfa89f20cdb3d8077f -X 'github.com/google/syzkaller/prog.gitRevisionDate=20220629-111539'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=1434eec0b84075b7246560cfa89f20cdb3d8077f -X 'github.com/google/syzkaller/prog.gitRevisionDate=20220629-111539'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"1434eec0b84075b7246560cfa89f20cdb3d8077f\"



Tested on:

commit:         08986606 Merge tag 'libnvdimm-fixes-5.19-rc5' of git:/..
git tree:       http://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=833001d0819ddbc9
dashboard link: https://syzkaller.appspot.com/bug?extid=be946efe33b2d9664348
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11871248080000

