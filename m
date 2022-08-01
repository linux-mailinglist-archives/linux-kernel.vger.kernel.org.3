Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B796958656C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiHAGzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHAGzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:55:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16C8F1834C
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 23:55:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1FBA1515;
        Sun, 31 Jul 2022 23:55:02 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 861FB3F73B;
        Sun, 31 Jul 2022 23:55:00 -0700 (PDT)
Date:   Mon, 1 Aug 2022 07:54:58 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Arun KS <arunks.linux@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com, Arun KS <getarunks@gmail.com>
Subject: Re: [RFC PATCH 15/16] selftests: arm64: Add initial SCMI testcases
Message-ID: <Yud4re9NC1Tjsoco@e120937-lin>
References: <20220227205608.30812-1-cristian.marussi@arm.com>
 <20220227205608.30812-16-cristian.marussi@arm.com>
 <CAKZGPAOvys8ddxr36WkfjAshZYBGWG6ecUMa8zGAPWhoEg=GVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKZGPAOvys8ddxr36WkfjAshZYBGWG6ecUMa8zGAPWhoEg=GVQ@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 10:22:19AM +0530, Arun KS wrote:
> Hi Cristian,
> 

Hi Arun,

[snip]
> > +setup_scmi_test_env()
> > +{
> > +       local scmi_info_dir="${SCMI_DEBUGFS_TOPDIR}/info/"
> > +
> > +       export SCMI_VENDOR="$(cat ${scmi_info_dir}/vendor_id)"
> > +       export SCMI_SUB_VENDOR="$(cat ${scmi_info_dir}/sub_vendor_id)"
> > +       export SCMI_VERS_MAJ="$(cat ${scmi_info_dir}/major_ver)"
> > +       export SCMI_VERS_MIN="$(cat ${scmi_info_dir}/minor_ver)"
> > +       export SCMI_VERS_IMPL="$(cat ${scmi_info_dir}/impl_ver)"
> > +
> > +       ksft_log "Found stack: $SCMI_VENDOR/$SCMI_SUB_VENDOR ${SCMI_VERS_MAJ}.${SCMI_VERS_MAJ} - $SCMI_VERS_IMPL"
> > +
> > +       SCMI_TEST_PROTOS=""
> > +       for p in ${SCMI_DEBUGFS_TOPDIR}/protocol_*; do
> > +               SCMI_TEST_PROTOS="${SCMI_TEST_PROTOS} $(basename $p)"
> > +       done
> > +
> > +       ksft_log "Found testing protocols: $SCMI_TEST_PROTOS"
> > +
> > +       export SCMI_TEST_PROTOS
> > +       SCMI_TRANSPORT_IS_ATOMIC="N"
> > +       [ -d "${SCMI_DEBUGFS_TOPDIR}/transport" ] &&
> > +               SCMI_TRANSPORT_IS_ATOMIC=$(cat "${SCMI_DEBUGFS_TOPDIR}/transport/is_atomic")
> > +       export SCMI_TRANSPORT_IS_ATOMIC
> > +}
> > +
> > +# Setup
> > +check_root_privs
> > +
> > +check_scmi_testing_stack
> > +
> > +setup_scmi_test_env
> > +
> > +# Main
> > +# Run all available tests for the found protocols
> > +#
> > +for proto_dir in $SCMI_TEST_PROTOS; do
> > +       [ ! -d $proto_dir ] && ksft_log "$proto_dir tests NOT supported." && continue
> > +       export TST_PROTO_DIR="${SCMI_DEBUGFS_TOPDIR}/${proto_dir}"
> > +       TST_PROTO_VERSION=$(cat ${TST_PROTO_DIR}/version)
> > +       ksft_log "Running tests for SCMI $proto_dir ver:$TST_PROTO_VERSION"
> > +       for tst in $proto_dir/*; do
> > +               ksft_scmi_run_one $tst
> > +       done
> > +done
> > +
> > +ksft_results
> > diff --git a/tools/testing/selftests/arm64/scmi/testcases/protocol_0x14/clock_enable.sh b/tools/testing/selftests/arm64/scmi/testcases/protocol_0x14/clock_enable.sh
> > new file mode 100755
> > index 000000000000..4cdf3a097ba7
> > --- /dev/null
> > +++ b/tools/testing/selftests/arm64/scmi/testcases/protocol_0x14/clock_enable.sh
> > @@ -0,0 +1,33 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +. ./kselftest_scmi_lib.sh
> > +
> > +supported_fw="EMU-SCMI-VM:userland"
> > +ksft_scmi_check_fw_version $supported_fw
> 
> what is the necessity of this check? Won't it limits the use of this
> common test script across multiple platforms?
> 

Yes, indeed the basic idea here was to showcase in this RFC series that
the testcases could be written so as to be run only on a restricted set
of platforms: the crux of the matter is that some of the SCMI tests by
their own nature can be very invasive and disruptive, but for the sake
of testing the Kernel stack some of those are worth to be run and, with
this 'version-bsed' approach, you could run it safely as long as you
deploy them against some sort of special emulated SCMI-server which is
is instead safe to be tested in any way (since no real clocks are in
fact involved...)

For this same reason, this kind of test tailored at a very special SCMI
server wouldn't be probably upstreamed unless you fw-emulation backend
is upstream in the open too, so I posted this test more to showcase the
version based mechanism than the test itself...

Thanks,
Cristian
