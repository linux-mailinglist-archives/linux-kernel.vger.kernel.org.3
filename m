Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503DF47C048
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbhLUNBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:01:31 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:16648 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237988AbhLUNB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:01:27 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BL9nuC4027858;
        Tue, 21 Dec 2021 08:01:20 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3d2pyqm2m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 08:01:20 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1BLD1Jck013994
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Dec 2021 08:01:19 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 21 Dec
 2021 08:01:18 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 21 Dec 2021 08:01:18 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.181])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1BLD1BQh024109;
        Tue, 21 Dec 2021 08:01:15 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v7 3/3] Documentation:ABI:testing:admv1013: add ABI docs
Date:   Tue, 21 Dec 2021 13:22:06 +0200
Message-ID: <20211221112206.97066-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211221112206.97066-1-antoniu.miclaus@analog.com>
References: <20211221112206.97066-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: G5c2vhHyJ2a6RujJvVibxsOz6svQ66o6
X-Proofpoint-ORIG-GUID: G5c2vhHyJ2a6RujJvVibxsOz6svQ66o6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_04,2021-12-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the use of the Local Oscillator Feedthrough Offset
calibration.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v7:
 - rename `phase` -> `calibphase`
 - specify that the phase values are unscaled
 .../testing/sysfs-bus-iio-frequency-admv1013  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
new file mode 100644
index 000000000000..105bae9e2f5c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
@@ -0,0 +1,38 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-1_i_calibphase
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write unscaled value for the Local Oscillatior path quadrature I phase shift.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-1_q_calibphase
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write unscaled value for the Local Oscillatior path quadrature Q phase shift.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_i_calibbias
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write value for the Local Oscillatior Feedthrough Offset Calibration I Positive
+		side.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_q_calibbias
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write value for the Local Oscillatior Feedthrough Offset Calibration Q Positive side.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage1_i_calibbias
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration I Negative
+		side.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage1_q_calibbias
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration Q Negative
+		side.
-- 
2.34.1

